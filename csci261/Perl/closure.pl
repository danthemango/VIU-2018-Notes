#!/usr/bin/perl

# File:closure.pl
# Example of closure
# Peter Walsh

sub add_function_generator {
  my $wow=5;
  return sub { 
     my ($x)=shift @_; 
     my ($y)=shift @_;
     $x + $y + $wow;
  };
}

$add_sub=add_function_generator();


$sum=$add_sub->(3,4);
print "$sum \n";
$sum=&$add_sub(3,4);
print "$sum \n";
