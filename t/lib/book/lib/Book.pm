package Book;

use strict;
use base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    # Routes
    my $r = $self->routes;

    $self->plugin( 'actioncache',
        { cache_option => { root_dir => $self->home->rel_dir('cache') } } );

    my $books = $r->route('/books')->to('controller-cache#books');
}

1;
