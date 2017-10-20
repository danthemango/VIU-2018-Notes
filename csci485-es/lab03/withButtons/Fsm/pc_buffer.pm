package Fsm::pc_buffer;

#================================================================--
# File Name    : Fsm/pc_buffer.moore
#
# Purpose      : producer consumer buffer (to drive the lights)
#
# Author       : Daniel Guenther, Vancouver Island University
#
# System       : Perl (Linux)
#
# Note:
#  - up to four things can be in our buffer currently
#=========================================================

$| = 1;
use strict;
use warnings;

use Table::SVAR;

my $moore_Current_State;
my $moore_Next_State;
my $moore_Initial_State;
no warnings "experimental::smartmatch";

$moore_Initial_State = "S0";
$moore_Next_State    = "S0";
my $task_ref = sub {
   $moore_Current_State = $moore_Next_State;

   my $ns;
   my $produce;
   my $consume;

# Current State Action Next State
# NOTE: we are creating four states, one for each possibile light
# there are probably more effective ways of coding this, but I want to be relatively explicit
# with the states of this machine, until we have undetermined sized buffers
   if ( $moore_Current_State ~~ "S0" ) {
      pc_Console::GUI->set_lights( "green", "green", "green", "green" );
      $produce = Table::SVAR->get_value("sv_produce");
      $consume = Table::SVAR->get_value("sv_consume");
      if ( $produce && !$consume ) {
         $ns = "S1";
      }
      elsif ( !$produce && !$consume ) {
         $ns = "S0";
      }
      else {
         $ns = "S0";
         die("overconsumption! (pc_buffer,S0)!");
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "S1" ) {
      pc_Console::GUI->set_lights( "red", "green", "green", "green" );
      $produce = Table::SVAR->get_value("sv_produce");
      $consume = Table::SVAR->get_value("sv_consume");

      # DEBUG checking signals
      print( "sv_produce " . $produce . " sv_consume " . $consume . "\n" );
      if ( $produce && !$consume ) {
         $ns = "S2";
      }
      elsif ( !$produce && $consume ) {
         $ns = "S0";
      }
      else {
         $ns = "S1";
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "S2" ) {
      pc_Console::GUI->set_lights( "red", "red", "green", "green" );
      $produce = Table::SVAR->get_value("sv_produce");
      $consume = Table::SVAR->get_value("sv_consume");
      if ( $produce && !$consume ) {
         $ns = "S3";
      }
      elsif ( !$produce && $consume ) {
         $ns = "S1";
      }
      else {
         $ns = "S2";
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "S3" ) {
      pc_Console::GUI->set_lights( "red", "red", "red", "green" );
      $produce = Table::SVAR->get_value("sv_produce");
      $consume = Table::SVAR->get_value("sv_consume");
      if ( $produce && !$consume ) {
         $ns = "S4";
      }
      elsif ( !$produce && $consume ) {
         $ns = "S2";
      }
      else {
         $ns = "S3";
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "S4" ) {
      pc_Console::GUI->set_lights( "red", "red", "red", "red" );
      $produce = Table::SVAR->get_value("sv_produce");
      $consume = Table::SVAR->get_value("sv_consume");
      if ( $produce && !$consume ) {
         die("overproduction! (pc_buffer, S4)");
      }
      elsif ( !$produce && $consume ) {
         $ns = "S3";
      }
      else {
         $ns = "S4";
      }
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

