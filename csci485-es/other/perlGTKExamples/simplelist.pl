#!/usr/bin/perl -w

use Data::Dumper;
use Gtk2 '-init';
use Gtk2::SimpleList;

use constant TRUE  => 1;
use constant FALSE => 0;

$window = Gtk2::Window->new;
$window->set_title ('SimpleList examples');
$window->signal_connect (delete_event => sub {Gtk2->main_quit; TRUE});
$window->set_default_size (320, -1);

$hbox = Gtk2::HBox->new;
$window->add ($hbox);

# a simple one-column list:
$categories = Gtk2::SimpleList->new ('Categories' => 'text');
@{$categories->{data}} = qw/Meat Beer Pizza Pasta Soda Juice Rabbitfood/;
$categories->signal_connect (row_activated => sub {
		my ($treeview, $path, $column) = @_;
		print "mmm, ".$categories->{data}[$_[1]->to_string][0]."\n";
	});
$hbox->pack_start ($categories, FALSE, FALSE, 0);



$slist = Gtk2::SimpleList->new (
              'Text Field'    => 'text',
              'Int Field'     => 'int',
              'Double Field'  => 'double',
              'Bool Field'    => 'bool',
              'Scalar Field'  => 'scalar',
              'Pixbuf Field'  => 'pixbuf',
            );

@{$slist->{data}} = (
        [ 'text', 1, 1.1,  TRUE, $window, $pixbuf ],
        [ 'text', 2, 2.2, FALSE, $categories, $pixbuf ],
        [ 'text', 3, 3.3, FALSE, $slist, $pixbuf ],
);

# (almost) anything you can do to an array you can do to
# $slist->{data} which is an array reference tied to the list model
push @{$slist->{data}}, [ 'text', 4, 4.4, TRUE, undef, undef ];

# mess with selections
$slist->get_selection->set_mode ('multiple');
$slist->get_selection->unselect_all;
$slist->select (1, 3, 5..9); # select rows by index
$slist->unselect (3, 8); # unselect rows by index
@sel = $slist->get_selected_indices;

# simple way to make text columns editable
$slist->set_column_editable (0, TRUE);
$slist->set_column_editable (1, TRUE);

# Gtk2::SimpleList is derived from Gtk2::TreeView, so you can
# do anything you'd do to a treeview.
$slist->set_rules_hint (TRUE);
$slist->set_reorderable (TRUE);
map { $_->set_resizable (TRUE) } $slist->get_columns;

# packed into a scrolled window...
$scrolled = Gtk2::ScrolledWindow->new;
$scrolled->set_policy ('automatic', 'automatic');
$scrolled->add ($slist);
$hbox->add ($scrolled);

# all in one go
$window->show_all;

Gtk2->main;
