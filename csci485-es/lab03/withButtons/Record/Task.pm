package Record::Task;
#================================================================--
# File Name    : Record/Task.pm
#
# Purpose      : implements Task record
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#=========================================================

$| = 1;
use strict;
use warnings;

my $period = ' ';
my $periodic = ' ';
my $elapsedTime = 0;
my $deadline = 0;
my $resetPtr = ' ';
my $taskPtr = ' ';

sub  new {
   my $class = shift @_;

   my $self = {period => $period,
      periodic => $periodic,
      elapsedTime => $elapsedTime,
      deadline => $deadline,
      resetPtr => $resetPtr,
      taskPtr => $taskPtr
   };
                
   bless ($self, $class);
   return $self;
}

sub get_period {
   my $self = shift @_;
   
   return $self->{period};
}

sub set_period {
   my $self = shift @_;
   my $p = shift @_;
 
   $self->{period} = $p;
   return;
}

sub get_elapsedTime {
   my $self = shift @_;
   
   return $self->{elapsedTime};
}

sub set_elapsedTime {
   my $self = shift @_;
   my $et = shift @_;
 
   $self->{elapsedTime} = $et;
   return;
}

sub get_taskPtr {
   my $self = shift @_;

   return $self->{taskPtr};
}

sub get_resetPtr {
   my $self = shift @_;

   return $self->{resetPtr};
}

sub set_periodic {
   my $self = shift @_;
   my $pflag = shift @_;
 
   $self->{periodic} = $pflag;
   return;
}

sub get_periodic {
   my $self = shift @_;

   return $self->{periodic};
}

sub set_taskPtr {
   my $self = shift @_;
   my $fp = shift @_;

   $self->{taskPtr} = $fp;
   return;
}

sub set_resetPtr {
   my $self = shift @_;
   my $fp = shift @_;

   $self->{resetPtr} = $fp;
   return;
}

sub set_deadline {
   my $self = shift @_;
   my $d = shift @_;
 
   $self->{deadline} = $d;
   return;
}

sub get_deadline {
   my $self = shift @_;

   return $self->{deadline};
}

sub dump {
   my $self = shift @_;

   print ("Period: $self->{period} \n");
   print ("Periodic: $self->{periodic} \n");
   print ("Deadline: $self->{deadline} \n");
   print ("Elapsed Time: $self->{elapsedTime} \n");
   print ("RESET Pointer: $self->{resetPtr} \n");
   print ("TASK Pointer: $self->{taskPtr} \n");
   return;
}

1;
