#!/usr/bin/perl

# =================================================
# Filename:   
#     pex3.pl
# Behaviour: 
#     Used to test a person's reaction time
#     - program waits for START (Ch2)
#     - waits three seconds and turns on STARTLED (DO1)
#     - waits a random number of seconds (less than 10), then turns on REACTLED (DO0)
#     - begins counting reaction time
#     - once REACT (Ch1) signal seen, displays the reaction time
#        - displays reaction time in seconds
#     - resets
# Timing:
#     - reactiontime has error of nearly 1 second
#     - reactiontime uses the Time::HiRes system to get Gystem time in microseconds
# Assumptions:
#     - DI-155 is correctly configured (listening on Ch1, Ch2. Outputting on DO0 and DO1)
# Board:
#      CME11-E9-EVBU
# Authors:
#     Daniel Guenther
#     Nathan Hogman
#     with help of code provided by Peter Walsh
# Date:       
#     2016-04-06
# =================================================

use strict;
use warnings;

use AnyEvent;
use Device::SerialPort;

#==============
#  exit signals 
#==============

#CTRL C to exit
$SIG{INT} = sub {leaveScript();};
sub leaveScript {
   print ("\nHalting Data Aquisition");
   print (" .. Good Bye\n");
   exit(0);
}

# catch die calls without exit
$SIG{__DIE__} = sub { };

my $y;

#========================
# Start implicit while(1)
#========================
$y = AnyEvent->condvar;

my @events;

sub addevents{
   push @events, AnyEvent->timer(
      after => 3,
      interval => 1,
      cb => sub {
         print("hello world\n");
      }
   );

   push @events, AnyEvent->timer(
      after => 4,
      interval => 2,
      cb => sub {
         print("hello WORLD\n");
      }
   );
}

sub beginSetup{
   my $activeEvent = AnyEvent->timer(
      after => 0,
      cb => sub {
      }
   );
}

$y->recv;

#========================
# End implicit while(1)
#========================
