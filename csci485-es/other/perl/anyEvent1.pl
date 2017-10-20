use AnyEvent;
use strict;

#condition, wait for timer is fired
my $timer_fired = AnyEvent->condvar;

my $w = AnyEvent->timer(
   after=>2,
   cb=>sub{
      print "hello world!\n";
      $timer_fired->send;
});

$timer_fired->recv;
