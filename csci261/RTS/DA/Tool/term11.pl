#!/usr/bin/perl
#========================================================
# Project      : A linux to tcp to serial hc11 
#                dev. board terminal
#
# File Name    : term11
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#========================================================

$SIG{INT} = sub {terminate("\tCTRL C entered");};

$|=1;

use strict;
use warnings;

use AnyEvent;
use AnyEvent::Socket;
use Sys::Hostname;

my %mapping = (
   "wolf4", "kit67:3000",
   "otter","kit67:3001"
);

my ($host, $machine, $port, $file);
$file = "pex0.s19";

$host = hostname;
my $mapstring = $mapping{$host};
if (defined($mapstring)) {
   ($machine,$port) = split(':',$mapping{$host});
}

for (my $i=0; $i <= $#ARGV; $i++) {
   if (defined $ARGV[$i]) {
      if ($ARGV[$i] eq "-m") {
         $machine = $ARGV[$i+1];
      } elsif ($ARGV[$i] eq "-f") {
         $file =  $ARGV[$i+1];
      } elsif ($ARGV[$i] eq "-v") {
         print('Version: 0.1 Feb 26 2016. Contact: peter.walsh@viu.ca' , "\n");
         exit(0);
      } elsif ($ARGV[$i] eq "-p") {
         $port = $ARGV[$i+1];
      } elsif ($ARGV[$i] eq "-h") {
         print("\nterm11 flags:\n");
         print("\t\t -h help\n");
         print("\t\t -v version\n");
         print("\t\t -m set EVBU host machine name\n");
         print("\t\t -p set EVBU host port number\n");
         print("\t\t -f set s19 records file name\n");
         print("\nterm11 commands:\n");
         print("\t\t buffalo monitor commands are passed to the EVBU \n\n");
         print("\t\t pwload will download the s19 records \n");
         print("\t\t (specified using -f switch) to the EVBU \n\n");
         print("\t\t CTRL C to exit term11\n");
         print("\nterm11 example invocation:\n");
         print("\t\t term11 -m kit70 -p 3001 -f pex0.s19\n");
         exit(0);
      }
   }
}

undef(@ARGV);

if ((!defined($machine)) or (!defined($port))) {
   terminate("ERROR: undefined host machine and/or undefined port");
}

my $sock;
my  (@stdin_fifo, @stdout_fifo, @task_fifo);
my ($e_event, $f_event, $g_event, $a_event, $z_event);
my ($process_stdin_ref, $process_stdout_ref);

tcp_connect $machine,  $port, sub {
   $sock = shift;
   if (!defined $sock) {
      terminate("ERROR: can not open socket");
   } else {
      push(@stdout_fifo, "Connection Established\n");
      push(@task_fifo, $process_stdout_ref);
   }
      
};

sub terminate {
   my $p = shift @_;

   print("$p - Bye\n");
   if (defined $sock) {
      close($sock);
   }
   exit();
}


$process_stdout_ref = sub {
   while (@stdout_fifo != 0) {
      print(shift(@stdout_fifo));
   }
};

$process_stdin_ref = sub  {
   my $command = shift(@stdin_fifo);
   #print("SENT->$command<- \n");
   $command = $command . "\r";
   if (defined($sock)) {
      syswrite($sock, $command);
   }
}; 

push(@stdout_fifo, "Starting HC11 Terminal at $machine on port $port using s19 records form $file\n");
push(@task_fifo, $process_stdout_ref);

$z_event = AnyEvent->condvar;

$a_event = AnyEvent->io(
   fh => \*STDIN,
   poll => "r",
   cb => sub {
      my $line = <STDIN>;
      chop($line);
      if ($line eq "pwload") {
         if (-r $file) {
            push(@stdin_fifo, "load t");
            push(@task_fifo, $process_stdin_ref);

            open(FH, "<$file");

            while(my $rec = <FH>) {
               chop($rec);
               push(@stdin_fifo, $rec);
               push(@task_fifo, $process_stdin_ref);
            }
         } else {
            terminate("ERROR: can not open file: $file");

         }
      } else {
         push(@stdin_fifo, $line);
         push(@task_fifo, $process_stdin_ref);
      }
    }
);

$e_event= AnyEvent->idle(
   cb => sub {
      if (@task_fifo !=0) {
         my $sr = shift(@task_fifo);
         $sr->();
      }
   }
);
               
$f_event = AnyEvent->timer (
   after => 1,
   interval => 0.02,
   cb => sub {
      my $ch_str;
      if (defined($sock)) {
         my $num=sysread($sock, $ch_str, 200);
         if (defined($num) && ($num != 0)) {
            push(@stdout_fifo, $ch_str);
            push(@task_fifo, $process_stdout_ref);
         }
      }
   }
);

$z_event->recv;

