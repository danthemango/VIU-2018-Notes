#!/usr/bin/perl
#========================================================
# Project      : Time Oriented Software Framework
#
# File Name    : tl.pl
#
# Purpose      : main routine of the traffic light example
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
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
use tl_Console::GUI;
use Table::SVAR;

use Fsm::tl_LTO;
use Fsm::tl_STO;
use Fsm::tl_CONN;

use constant TRUE => 1;
use constant FALSE => 0;
use constant TIMERPERIOD => 0.1; # measured in seconds

my $idle_event;
my $schedular_event;

sub leaveScript {
   system("rm -f /tmp/pw*");
   print("Shutdown Now !!!!! \n");
   exit();
}

my $tl = Exc::TryCatch->new(
   fn => sub {

      Table::TASK->create(
         name => "tl_LTO", 
         periodic => FALSE, 
	 run => TRUE,
	 resetPtr => Fsm::tl_LTO->get_reset_ref(),
         taskPtr => Fsm::tl_LTO->get_task_ref()
      );

      Table::TASK->create(
         name => "tl_STO", 
         periodic => FALSE, 
	 run => TRUE,
	 resetPtr => Fsm::tl_STO->get_reset_ref(),
         taskPtr => Fsm::tl_STO->get_task_ref()
      );

      Table::TASK->create(
         name => "tl_CONN", 
         periodic => FALSE, 
	 run => TRUE,
	 resetPtr => Fsm::tl_CONN->get_reset_ref(),
         taskPtr => Fsm::tl_CONN->get_task_ref()
      );

      Table::SVAR->add(name => "sv_car", value => 0);
      Table::SVAR->add(name => "sv_lto", value => 0);
      Table::SVAR->add(name => "sv_sto", value => 0);

      Event::SCHEDULAR->start(\$schedular_event, TIMERPERIOD);

      Event::IDLE->start(\$idle_event);

   }
);

$tl->run();
tl_Console::GUI->start();
## Now enter Gtk2's event loop
main Gtk2;

