package product::Default;

use strict;
use warnings;
use base 'Mojolicious::Controller';

sub list {
    my $self = shift;

    # Render template "default/list.html.ep" with message
    $self->render( message => 'Showing list of product!' );
}

sub type {
    my $self = shift;

    # render default/type.html.ep
    $self->render( message => 'we have '.$self->stash('type') );
}

sub show {
    my $self = shift;

    # render default/show.html.ep
    $self->render( message => 'showing product for ' . $self->stash('id') );
}

1;
