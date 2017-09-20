#!/usr/bin/perl
################################################
# Filename: int.pl
# Author: Daniel Guenther (565154853)
# Date: 2016-01-21
# Class: CSCI 261
# 
# Purpose: to convert SSBC assembly code to machine code
################################################
use strict;
use warnings;

#hash of arguments and opcode pairs
my %opcodes = (
   "noop" => "00",
   "halt" => "01",
   "pushimm" => "02",
   "pushext" => "03",
   "popinh" => "04",
   "popext" => "05",
   "jnz" => "06",
   "jnn" => "07",
   "add" => "08",
   "sub" => "09",
   "nor" => "0A"
);

my $outfile = "mac";

#ensure the filename was passed in
if(@ARGV != 1){
   print "Usage $0 filename\n";
   exit;
}

#open the file
my $file = $ARGV[0];
open(INFILE, $file)
   or die "could not open $file\n";
open(OUTFILE, $outfile)
   or die "could not open $outfile\n";

#line number
my $lnum = 0;
while (<INFILE>){
   #get the words from the line
   my @wordlist = split ' ',$_;
   # ensure the line starts with an opcode
   if(!exists $opcodes{$wordlist[0]}){
      print "$wordlist[0] is not a valid opcode\n";
      print "refer to the artn for more information\n";
      exit;
   }
   # process opcode
   # TODO
}

sub h2b($){
   while (<>) {
      chop;
      for (my $i = 0; $i < length($_); $i += 1) {
         printf('%04b', hex(substr($_, $i, 1)))
      }
      print "\n";
   }
}
