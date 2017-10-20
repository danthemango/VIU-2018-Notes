#!/usr/bin/perl

use strict;
use Data::Dumper;
use Gtk2 '-init';

my $window = Gtk2::Window->new;
$window->set_title('Simple Signals');

#make alt-f4 work
$window->signal_connect(destroy=>sub{ Gtk2->main_quit;});

# create a button
my $button = Gtk2::Button->new('Click me to quit');

my $user_data = "hello";

# run a function with data on click
$button->signal_connect(clicked=>\&button_callback, $user_data);
# add it to the window
$window->add($button);

$window->show_all;
Gtk2->main;

sub button_callback
{
   print Dumper(@_);
   Gtk2->main_quit;
   1;
}
