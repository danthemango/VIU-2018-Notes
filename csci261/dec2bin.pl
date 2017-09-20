#!/usr/bin/perl
################################################
# Filename: dec2bin.pl
# Author: Daniel Guenther (565154853)
# Date: 2016-01-27
# Class: CSCI 261
# 
# Purpose: convert decimal number to a 16-digit binary number
################################################
use strict;
use warnings;

#tell the user what's up when they forgot to include relevant information
if(@ARGV < 1){
   print "dec2bin will convert a decimal number to an equivalent 16-digit binary representation\n"
   print "usage: perl dec2bin <number>\n"
}

my $num = $ARGV[0];
printf('%016b', $num);
print "\n";
