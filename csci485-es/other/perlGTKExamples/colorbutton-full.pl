#!/usr/bin/perl -w

use strict;

package Mup::ColorButton;

use Gtk2;
use Glib::Object::Subclass
    Gtk2::Button::,
    signals => {
	color_changed => {},
	show => \&on_show,
    },
    properties => [
	Glib::ParamSpec->int (
	    	'red',
		'Red',
		'The Red component of the RGB color',
		0,
		0xffff,
		0xffff,
		[qw/readable writable/]
	),
	Glib::ParamSpec->int (
	    	'green',
		'Green',
		'The Green component of the RGB color',
		0,
		0xffff,
		0xffff,
		[qw/readable writable/]
	),
	Glib::ParamSpec->int (
	    	'blue',
		'Blue',
		'The Blue component of the RGB color',
		0,
		0xffff,
		0xffff,
		[qw/readable writable/]
	),
    ]
    ;

sub INIT_INSTANCE {
	my $self = shift;
	$self->{red} = 0xffff;
	$self->{green} = 0xffff;
	$self->{blue} = 0xffff;

	my $frame = Gtk2::Frame->new;
	$frame->set_border_width (3);
	$frame->set_shadow_type ('etched-in');
	$self->add ($frame);
	$frame->show;
	my $event_box = Gtk2::EventBox->new;
	$event_box->set_size_request (14, 14);
	$frame->add ($event_box);
	$event_box->show;
	$self->{colorbox} = $event_box;
}

sub on_show {
	my $self = shift;
	$self->set_color (red => $self->{red},
	                  green => $self->{green},
	                  blue => $self->{blue});
	$self->signal_chain_from_overridden;
}

sub set_color {
	my $self = shift;
	my %params = @_;
	my $color = Gtk2::Gdk::Color->new ($params{red},
	                                   $params{green},
	                                   $params{blue});
	$self->{colorbox}->get_colormap->alloc_color ($color, 0, 1);
	$self->{colorbox}->modify_bg ('normal', $color);
	$self->{colorbox}->modify_bg ('active', $color);
	$self->{colorbox}->modify_bg ('prelight', $color);
	$self->{red} = $params{red};
	$self->{green} = $params{green};
	$self->{blue} = $params{blue};
	$self->signal_emit ('color-changed');
}

package main;

use Gtk2 -init;

my $window = Gtk2::Window->new;
$window->set_title ('Color buttons');
$window->set_border_width (6);
$window->signal_connect (delete_event => sub { Gtk2->main_quit; 1 });

my $vbox = Gtk2::VBox->new;
$window->add ($vbox);
$vbox->show;

my $foo = Mup::ColorButton->new (red => 0xaaaa, green => 0x0, blue => 0xffff);
$vbox->pack_start ($foo, 1, 1, 0);
$foo->show;

$foo->signal_connect (clicked => sub {
		my $self = shift;
		my $dialog = Gtk2::ColorSelectionDialog->new ('pick a color');
		my $c = Gtk2::Gdk::Color->new ($self->{red},
		                               $self->{green},
		                               $self->{blue});
		$self->{colorbox}->get_colormap->alloc_color ($c, 0, 1);
		$dialog->colorsel->set_current_color ($c);
		if ('ok' eq $dialog->run) {
			my $c = $dialog->colorsel->get_current_color;
			$self->set_color (red => $c->red,
			                  green => $c->green,
			                  blue => $c->blue);
		}
		$dialog->destroy;
	});

$foo->signal_connect (color_changed => sub {
		warn "the color changed - now "
		   . join (", ", $_[0]->get (qw/red green blue/))
		   . ".  i should do something!";
	});

$window->show;
Gtk2->main;
