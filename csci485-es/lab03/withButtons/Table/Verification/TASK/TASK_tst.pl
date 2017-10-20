#!/usr/bin/perl
######################################################
# Peter Walsh
# File: Table/Verification/TASK/TASK_tst.pl
# Module test driver
######################################################

$| = 1;
use strict;
use warnings;

use lib '../../../';
use Try::Tiny;
use Exc::Exception;
use Exc::TryCatch;
use Table::TASK;

my $tst = Exc::TryCatch->new(
   fn => sub {
      Table::TASK->add(name => "T1", 
         period => 1, 
         elapsedTime => 0, 
         periodic => 1, 
         deadline => 6,
         fsmPtr => "DUMMY"
      );

      Table::TASK->add(name => "T2", 
         period => 1, 
         elapsedTime => 0, 
         periodic => 1, 
         deadline => 6,
         fsmPtr => "DUMMY"
      );
      
      Table::TASK->dump();

   }
);

$tst->run();
