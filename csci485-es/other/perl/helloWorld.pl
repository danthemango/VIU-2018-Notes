#!/usr/bin/perl -w

use strict;
use Gtk2 '-init';

my $window = Gtk2::Window->new;
my $label = Gtk2::Label->new('Hello World!');
$window->add($label);
$window->show_all;
Gtk2->main;
