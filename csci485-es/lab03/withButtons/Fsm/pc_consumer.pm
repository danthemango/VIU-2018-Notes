package Fsm::pc_consumer;

#================================================================--
# File Name    : Fsm/pc_consumer.moore
#
# Purpose      : the consumer machine
#
# Author       : Daniel Guenther, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

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
   # check buffer state used to check if the buffer has some elements to consume
   if ( $moore_Current_State ~~ "checkBuffer" ) {
      print("S1\n");
      if ( Table::SVAR->get_value("sv_consumer_enable") ) {
         print("Consumption start\n");
         Table::SEMAPHORE->wait(
            semaphore => "fillCount",
            task      => "pc_consumer"
         );
         $ns = "checkMutex";
      }
      else {
         print("Consumer disabled\n");
         $ns = "checkBuffer";
      }
      $moore_Next_State = $ns;
      return;
   }

   # check if the buffer is open for reading
   if ( $moore_Current_State ~~ "checkMutex" ) {
      print("S2\n");
      Table::SEMAPHORE->wait(
         semaphore => "bufferLockMutex",
         task      => "pc_consumer"
      );
      $ns               = "consumptionStart";
      $moore_Next_State = $ns;
      return;
   }

   # consumer item
   if ( $moore_Current_State ~~ "consumptionStart" ) {
      print("S3\n");
      print("consuming\n");
      Table::SVAR->assign( "sv_consume", 1 );
      $ns               = "consumptionEnd";
      $moore_Next_State = $ns;
      return;
   }

   # finish consumption
   if ( $moore_Current_State ~~ "consumptionEnd" ) {
      print("S4\n");
      Table::SVAR->assign( "sv_consume", 0 );
      Table::SEMAPHORE->signal( semaphore => "bufferLockMutex" );
      Table::SEMAPHORE->signal( semaphore => "emptyCount" );

      # NOTE: the thing pulled from the buffer would be consumed here
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

