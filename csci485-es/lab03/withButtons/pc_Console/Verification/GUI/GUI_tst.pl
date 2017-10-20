#!/usr/bin/perl
######################################################
# Peter Walsh
# GUI test driver
######################################################

$|=1;

use strict;
use warnings;
use lib '../../../';
use pc_Console::GUI;
use AnyEvent;
use Gtk2 -init;
use constant FALSE => 0;
use constant TRUE => 1;
use Exc::TryCatch;

my $state = 0;

my $pc = AnyEvent->timer(
   after => 3,
   interval => 3,
   cb => sub {
      if ($state == 0) {
         pc_Console::GUI->set_lights("green", "green", "green", "green");
      } elsif ($state == 1) {
         pc_Console::GUI->set_lights("red", "green", "green", "green");
      } elsif ($state == 2) {
         pc_Console::GUI->set_lights("red", "red", "green", "green");
      } elsif ($state == 3) {
         pc_Console::GUI->set_lights("red", "red", "red", "green");
      } elsif ($state == 4) {
         pc_Console::GUI->set_lights("red", "red", "red", "red");
      }

      if ($state == 4) {
         $state = 0;
      } else {
         $state = $state + 1;
      }
   }
);

pc_Console::GUI->start();

main Gtk2;
