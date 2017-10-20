#================================================================--
# File Name    : Record/Verification/Task/tb.cew
#
# Purpose      : unit testing
#
# Author       : Peter Walsh, Vancouver Island University
#
# System       : Perl (Linux)
#
#================================================================--

$| = 1;
use strict;
use warnings;

use lib '../../../';
use Exc::Exception;
use Record::Task;
use Try::Tiny;

my $cew_Test_Count  = 0;
my $cew_Error_Count = 0;
no warnings "experimental::smartmatch";

sub leaveScript {
   print("\n**********Summary**********\n");
   print( "Total number of test cases = ",          $cew_Test_Count,  "\n" );
   print( "Total number of test cases in error = ", $cew_Error_Count, "\n" );

   print("Bye\n");
   exit(0);
}

$SIG{INT} = sub { leaveScript(); };

my $x = Record::Task->new();
$x->set_deadline('23');

$cew_Test_Count = $cew_Test_Count + 1;
do {
   try {
      ;
      my $xact = $x->get_deadline();
      my $xexp = '23';
      if ( !( ($xact) ~~ ($xexp) ) ) {
         $cew_Error_Count = $cew_Error_Count + 1;
         print( "Test Case ERROR (Ncase) in script at line number ", 36, "\n" );

         if ( !defined($xact) ) {
            $xact = "undefined";
         }
         if ( !defined($xexp) ) {
            $xexp = "undefined";
         }

         print( "Actual Value is ",   $xact, " \n" );
         print( "Expected Value is ", $xexp, "\n" );
      }
   }
   catch {
      my $cew_e = $_;
      if ( ref($cew_e) ~~ "Exc::Exception" ) {
         my $cew_exc_name = $cew_e->get_name();
         $cew_Error_Count = $cew_Error_Count + 1;
         print( "Test Case ERROR (Ncase) in script at line number ", 36, "\n" );
         print( "Unexpected Exception ", $cew_exc_name, " thrown \n" );
      }
   }
};

print("\n**********Summary**********\n");
print( "Total number of test cases = ",          $cew_Test_Count,  "\n" );
print( "Total number of test cases in error = ", $cew_Error_Count, "\n" );

