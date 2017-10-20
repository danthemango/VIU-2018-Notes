package Event::SCHEDULAR;
#================================================================--
# File Name    : Event/SCHEDULAR.pm
#
# Purpose      : schedular event
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

$| = 1;
use strict;
use warnings;
#no warnings "experimental::smartmatch";

use AnyEvent;
use Exc::Exception;
use Exc::TryCatch;
use Table::QUEUE;
use Table::TASK;
use Table::SEMAPHORE;
use Table::SVAR;

sub start {
   my $self = shift @_;
   my $event_ptr = shift @_;
   my $event_interval = shift @_;
   my $cnt=0;

   my $mycb = Exc::TryCatch->new(
      fn => sub {

         my @keys = Table::TASK->get_keys();
         my $k;
   
         if (Table::QUEUE->get_siz('task')) {
            die(Exc::Exception->new(name => "Event::SCHEDULAR->start not all tasks executed on the previous cycle"));
         }

         Table::SVAR->update();

         foreach $k (@keys) {

            if (Table::TASK->get_periodic($k)) { 
               Table::TASK->increment_elapsedTime($k);
               if (!Table::TASK->get_blocked($k)) {
                  if (Table::TASK->get_elapsedTime($k) > Table::TASK->get_deadline($k)) {
                     die(Exc::Exception->new(name => "Event::SCHEDULAR->start task $k missed deadline"));
                  }
                  Table::QUEUE->enqueue('task', Table::TASK->get_taskPtr($k));
               } else {
                  if (Table::TASK->get_elapsedTime($k) >= Table::TASK->get_period($k)) {
                     Table::TASK->resume($k);
                  } 
               }
            } else {
               if (!Table::TASK->get_blocked($k)) {
                  Table::QUEUE->enqueue('task', Table::TASK->get_taskPtr($k));
               }
            }

         }
      }
   );

   $$event_ptr = AnyEvent->timer (
      after => 1,
      interval => $event_interval,
      cb => $mycb->get_wfn()
   );
}

1;
