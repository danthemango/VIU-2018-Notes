#!/usr/bin/perl

# File:ev0.pl
# Example AnyEvent usage
# Peter Walsh

use AnyEvent;

$y = AnyEvent->condvar;

$w = AnyEvent->timer (
   after => 3, 
   interval => 3, 
   cb => sub { 
      warn "timer\n"
   }
);

$x = AnyEvent->io (
   fh => \*STDIN,
   poll => "r",
   cb => sub {
      $line = <>; warn "io\n"
   }
);

$task_id=0;

$z= AnyEvent->idle(
   cb => sub { 
      print ("task ", $task_id, "\n");
      sleep $task_id; 
      $task_id = (($task_id +1) % 5)
   }
);

$y->recv;

