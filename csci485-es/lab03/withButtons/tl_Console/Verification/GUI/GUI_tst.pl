#!/usr/bin/perl
######################################################
# Peter Walsh
# GUI test driver
######################################################

$|=1;

use strict;
use warnings;
use lib '../../../';
use tl_Console::GUI;
use AnyEvent;
use Gtk2 -init;
use constant FALSE => 0;
use constant TRUE => 1;
use Exc::TryCatch;
use Table::SVAR;

my $state = 0;
# Note, the GUI icallback is not wrapped in
# a try catch block so will not trap cew exceptions 
Table::SVAR->add(name => "sv_car", value => 0);
my $d = AnyEvent->timer(
   after => 3,
   interval => 3,
   cb => sub {
      if ($state == 0) {
         tl_Console::GUI->set_lights("gray", "gray", "green", "red", "gray", "gray");
         $state = 1;
      } elsif ($state == 1) {
         tl_Console::GUI->set_lights("gray", "yellow", "gray", "red", "gray", "gray");
         $state = 2;
      } elsif ($state == 2) {
         tl_Console::GUI->set_lights("red", "gray", "gray", "gray", "gray", "green");
         $state = 3;
      } elsif ($state == 3) {
      tl_Console::GUI->set_lights("red", "gray", "gray", "gray", "yellow", "gray");
         $state = 0;
      }
   }

);

tl_Console::GUI->start();

main Gtk2;
