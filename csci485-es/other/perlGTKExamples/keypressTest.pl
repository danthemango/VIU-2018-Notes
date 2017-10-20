 #!/usr/bin/perl

# http://www.perlmonks.org/?node_id=1003488

use strict;
use Gtk2 -init;
use Gtk2::Gdk::Keysyms;

my $win = Gtk2::Window->new('toplevel');

$win->signal_connect(destroy => sub { Gtk2->main_quit });
$win->signal_connect(key_press_event => \&report_press);
$win->signal_connect(key_release_event => \&report_release);
my $but = Gtk2::Button->new('No Shift');
$but->signal_connect(clicked => \&report_click);
$win->add($but);
$win->show_all;
Gtk2->main;

sub report_click
{
    my $w = shift;
    print $w->get_label, "\n";
}

sub report_press
{
    my $w = shift;
    my $ev = shift;
    if($ev->keyval == $Gtk2::Gdk::Keysyms{Shift_L}
         || $ev->keyval == $Gtk2::Gdk::Keysyms{Shift_R})
    {
        $but->set_label("With Shift");
    }
    return;
}

sub report_release
{
    my $w = shift;
    my $ev = shift;
    if($ev->keyval == $Gtk2::Gdk::Keysyms{Shift_L} 
        || $ev->keyval == $Gtk2::Gdk::Keysyms{Shift_R})
    {
        $but->set_label("No Shift");
    }
    return;
}
