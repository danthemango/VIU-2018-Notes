package Fsm::tl_LTO;

#================================================================--
# File Name    : Fsm/tl_LTO.moore
#
# Purpose      : task long time out
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

$| = 1;
use strict;
use warnings;

use constant TIMEOUT => 100;

my $count;

sub nextState {
   my $c = shift @_;

   if ( $c == TIMEOUT ) {
      return ("S2");
   }
   else {
      return ("S1");
   }
}

my $moore_Current_State;
my $moore_Next_State;
my $moore_Initial_State;
no warnings "experimental::smartmatch";

$moore_Initial_State = "S0";
$moore_Next_State    = "S0";
my $task_ref = sub {
   $moore_Current_State = $moore_Next_State;

   if ( $moore_Current_State ~~ "S0" ) {
      $count            = 1;
      $moore_Next_State = "S1";
      return;
   }

   if ( $moore_Current_State ~~ "S1" ) {
      $count            = $count + 1;
      $moore_Next_State = nextState($count);
      return;
   }

   if ( $moore_Current_State ~~ "S2" ) {
      Table::SVAR->assign( "sv_lto", 1 );
      $moore_Next_State = "S3";
      return;
   }

   if ( $moore_Current_State ~~ "S3" ) {
      ;
      $moore_Next_State = "S3";
      return;
   }

};

my $reset_ref = sub {
   Table::SVAR->assign( "sv_lto", 0 );
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

