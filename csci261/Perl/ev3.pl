#!/usr/bin/perl

# File:ev3.pl
# Simple shell template
# Peter Walsh 

$|=1;

use AnyEvent;

my $line;
my $command;
my @stdin_fifo;
my @stdout_fifo;
my @task_fifo;
my @cop_fifo;

$y_event = AnyEvent->condvar;

print("shell: ");

$process_stdout_ref = sub {
   while (@stdout_fifo != 0) {
      print(shift(@stdout_fifo));
   }
   print("shell: ");
};

$process_stdin_ref = sub {
   $command = shift(@stdin_fifo);
   chop($command);
   if ($command eq "h") {
      push(@stdout_fifo, "Commands: h(elp), l(ist), p(ing) ip, q(uit)\n");
   } elsif ($command eq "l") {
      push(@stdout_fifo, ("stdout_fifo: " . scalar(@stdout_fifo) . "\n"));
      push(@stdout_fifo, ("stdin_fifo: " . scalar(@stdin_fifo) . "\n"));
      push(@stdout_fifo, ("task_fifo: " . scalar(@task_fifo) . "\n"));
      push(@stdout_fifo, ("cop_fifo: " . scalar(@cop_fifo) . "\n"));
   } elsif ($command eq "p") {
      push(@stdout_fifo, "PING\n");
   } elsif ($command eq "q") {
      push(@stdout_fifo, "QUIT\n");
      exit(0);
   } else {
      push(@stdout_fifo, "ERROR type h<CR> for help\n");
   }
   push(@task_fifo, $process_stdout_ref);
}; 

$x_event = AnyEvent->io (
   fh => \*STDIN,
   poll => "r",
   cb => sub {
      $line = <>;
      push(@stdin_fifo, $line);
      push(@task_fifo, $process_stdin_ref);
   }
);

$w_event = AnyEvent->timer (
   after => 1,
   interval => 1,
   cb => sub {
      push(@cop_fifo, "t");
      if (@cop_fifo == 20) {
         $#cop_fifo = -1;
      }
   }
);

$p_event = AnyEvent->timer (
   after => 10,
   interval => 10,
   cb => sub {
      push(@stdin_fifo, "l ");
      push(@task_fifo, $process_stdin_ref);
   }
);

$z_event= AnyEvent->idle(
   cb => sub {
      if (@task_fifo !=0) {
         $sr = shift(@task_fifo);
         $sr->();
      }
   }
);
               

$y_event->recv;
