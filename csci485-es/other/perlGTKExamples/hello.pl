#! /usr/bin/perl -w
use strict;
use Gtk2 -init;
use constant FALSE => 0;
use constant TRUE => 1;

my $window = Gtk2::Window->new ('toplevel');
$window->signal_connect (delete_event => sub { Gtk2->main_quit });

my $vbox = Gtk2::VBox->new(FALSE,5);
my $label = Gtk2::Label->new('Hello');
my $label2 = Gtk2::Label->new('World');
$vbox->pack_start($label, FALSE, FALSE, 0);
$vbox->pack_start($label2, FALSE, FALSE, 0);

#my $button = Gtk2::Button->new ('Action');
#$button->signal_connect (clicked => sub { 
#      print("Hello Gtk2-Perl\n");
#      });
#$window->add ($button);

$window->add ($vbox);
$window->show_all;
Gtk2->main;

