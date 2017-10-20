package Fsm::pc_producer;

#================================================================--
# File Name    : Fsm/pc_producer.moore
#
# Purpose      : the producer machine
#
# Author       : Daniel Guenther, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

# TODO finish this

$| = 1;
use strict;
use warnings;

use Table::SVAR;
use Table::SEMAPHORE;

my $moore_Current_State;
my $moore_Next_State;
my $moore_Initial_State;
no warnings "experimental::smartmatch";

$moore_Initial_State = "checkBuffer";
$moore_Next_State    = "checkBuffer";
my $task_ref = sub {
   $moore_Current_State = $moore_Next_State;

   my $ns;

# Current State Action Next State
# check buffer state used to check if the buffer has some space to hold anything produced
   if ( $moore_Current_State ~~ "checkBuffer" ) {

      # ensure the producer is currently enabled
      if ( Table::SVAR->get_value("sv_producer_enable") ) {
         print("Producer start\n");
         Table::SEMAPHORE->wait(
            semaphore => "emptyCount",
            task      => "pc_producer"
         );
         print( Table::SEMAPHORE->get_value("emptyCount") );
         print("\n");
         $ns = "checkMutex";
      }
      else {
         print("Producer disabled\n");
         $ns = "checkBuffer";
      }
      $moore_Next_State = $ns;
      return;
   }

   # check if the buffer is open for writing
   if ( $moore_Current_State ~~ "checkMutex" ) {
      Table::SEMAPHORE->wait(
         semaphore => "bufferLockMutex",
         task      => "pc_producer"
      );
      $ns               = "productionStart";
      $moore_Next_State = $ns;
      return;
   }

   # produce item
   if ( $moore_Current_State ~~ "productionStart" ) {
      print("Producing\n");
      Table::SVAR->assign( "sv_produce", 1 );
      $ns               = "productionEnd";
      $moore_Next_State = $ns;
      return;
   }

   # finish production
   if ( $moore_Current_State ~~ "productionEnd" ) {
      Table::SVAR->assign( "sv_produce", 0 );
      Table::SEMAPHORE->signal( semaphore => "bufferLockMutex" );

      # DEBUG check the lock mutex
      Table::SEMAPHORE->signal( semaphore => "fillCount" );
      $ns               = "checkBuffer";
      $moore_Next_State = $ns;
      return;
   }

};

my $reset_ref = sub {
   ;
   $moore_Next_State = $moore_Initial_State;
   return;
};

sub get_task_ref {
   my $pkg = shift @_;

   return ($task_ref);
}

sub get_reset_ref {
   my $pkg = shift @_;

   return ($reset_ref);
}

1;

