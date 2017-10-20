package Fsm::tl_CONN;

#================================================================--
# File Name    : Fsm/tl_CONN.moore
#
# Purpose      : task traffic light controller
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

$| = 1;
use strict;
use warnings;

use Table::SVAR;

my $moore_Current_State;
my $moore_Next_State;
my $moore_Initial_State;
no warnings "experimental::smartmatch";

$moore_Initial_State = "HG";
$moore_Next_State    = "HG";
my $task_ref = sub {
   $moore_Current_State = $moore_Next_State;

   my $ns;

   # Current State Action Next State

   if ( $moore_Current_State ~~ "HG" ) {
      tl_Console::GUI->set_lights( "gray", "gray", "green", "red", "gray",
         "gray" );
      my $car = Table::SVAR->get_value("sv_car");
      my $lto = Table::SVAR->get_value("sv_lto");
      my $sto = Table::SVAR->get_value("sv_sto");
      if ( !( $car && $lto ) ) {
         $ns = "HG";
      }
      else {
         $ns = "HY";
         Table::TASK->reset("tl_STO");
         Table::TASK->reset("tl_LTO");
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "HY" ) {
      tl_Console::GUI->set_lights( "gray", "yellow", "gray", "red", "gray",
         "gray" );
      my $car = Table::SVAR->get_value("sv_car");
      my $lto = Table::SVAR->get_value("sv_lto");
      my $sto = Table::SVAR->get_value("sv_sto");
      if ( !$sto ) {
         $ns = "HY";
      }
      else {
         $ns = "FG";
         Table::TASK->reset("tl_STO");
         Table::TASK->reset("tl_LTO");
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "FG" ) {
      tl_Console::GUI->set_lights( "red", "gray", "gray", "gray", "gray",
         "green" );
      my $car = Table::SVAR->get_value("sv_car");
      my $lto = Table::SVAR->get_value("sv_lto");
      my $sto = Table::SVAR->get_value("sv_sto");
      if ( ( $car || ( !$sto ) ) && ( !$lto ) ) {
         $ns = "FG";
      }
      else {
         $ns = "FY";
         Table::TASK->reset("tl_STO");
         Table::TASK->reset("tl_LTO");
      }
      $moore_Next_State = $ns;
      return;
   }

   if ( $moore_Current_State ~~ "FY" ) {
      tl_Console::GUI->set_lights( "red", "gray", "gray", "gray", "yellow",
         "gray" );
      my $car = Table::SVAR->get_value("sv_car");
      my $lto = Table::SVAR->get_value("sv_lto");
      my $sto = Table::SVAR->get_value("sv_sto");
      if ( !$sto ) {
         $ns = "FY";
      }
      else {
         $ns = "HG";
         Table::TASK->reset("tl_STO");
         Table::TASK->reset("tl_LTO");
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
