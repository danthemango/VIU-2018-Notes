#!/usr/bin/perl
#========================================================
# Project      : Time Oriented Software Framework
#
# File Name    : pc.pl
#
# Purpose      : main routine of the producer/consumer example
#
# Author       : Daniel Guenther (565154853) - VIU
#
# System       : Perl (Linux)
#
# Sources
#     - much of this code is an adaptation of Peter Walsh's Traffic Light example
#========================================================

$SIG{INT} = sub {leaveScript();};

$|=1;

use strict;
use warnings;
no warnings "experimental::smartmatch";

use lib './';
use AnyEvent;
use Gtk2 -init;
use Table::QUEUE;
use Table::TASK;
use Table::SEMAPHORE;
use Event::IDLE;
use Event::SCHEDULAR;
use Exc::Exception;
use Exc::TryCatch;
use Try::Tiny;
use pc_Console::GUI;
use Table::SVAR;

# responsible for setting the lights, responds to 'consume' and 'produce' signals
use Fsm::pc_buffer;
use Fsm::pc_producer;
use Fsm::pc_consumer;

use constant TRUE => 1;
use constant FALSE => 0;
use constant TIMERPERIOD => 0.1; # measured in seconds
use constant BUFSIZE => 4; # number of elements in buffer

my $idle_event;
my $schedular_event;

sub leaveScript {
   system("rm -f /tmp/pw*");
   print("Shutdown Now !!!!! \n");
   exit();
}

my $tl = Exc::TryCatch->new(
   fn => sub {

      # buffer FSM, which will initiate which will receive production/consumption signals
      # and adjusts the display accordingly
      Table::TASK->create(
         name => "pc_buffer", 
         periodic => FALSE, 
         run => TRUE,
         resetPtr => Fsm::pc_buffer->get_reset_ref(),
         taskPtr => Fsm::pc_buffer->get_task_ref()
      );

      # produce FSM
      Table::TASK->create(
         name => "pc_producer", 
         periodic => FALSE, 
         run => TRUE,
         resetPtr => Fsm::pc_producer->get_reset_ref(),
         taskPtr => Fsm::pc_producer->get_task_ref()
      );

      # consumer FSM
      Table::TASK->create(
         name => "pc_consumer", 
         periodic => FALSE, 
         run => TRUE,
         resetPtr => Fsm::pc_consumer->get_reset_ref(),
         taskPtr => Fsm::pc_consumer->get_task_ref()
      );

      # two signals to pass for the producer and consumer to pass to the buffer FSM
      Table::SVAR->add(name => "sv_consume", value => 0);
      Table::SVAR->add(name => "sv_produce", value => 0);
      # two more signals to turn toggle the producer and consumer tasks
      Table::SVAR->add(name => "sv_producer_enable", value => 0);
      Table::SVAR->add(name => "sv_consumer_enable", value => 0);

      # two semaphores to ensure buffer is not over/underfilled
      Table::SEMAPHORE->add(name => "emptyCount", value => 4, max => 4);
      Table::SEMAPHORE->add(name => "fillCount", value => 0, max => 4);
      # one mutex to ensure access is granted
      Table::SEMAPHORE->add(name => "bufferLockMutex", value => 1);

      Event::SCHEDULAR->start(\$schedular_event, TIMERPERIOD);

      Event::IDLE->start(\$idle_event);
   }
);

$tl->run();
pc_Console::GUI->start();
## Now enter Gtk2's event loop
main Gtk2;
