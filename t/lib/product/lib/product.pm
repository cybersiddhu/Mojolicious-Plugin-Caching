package product;

use strict;
use warnings;

use base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    # Routes
    my $r = $self->routes;

    $self->plugin('cache-page');

    my $product = $r->route('/product');
    $product->get('/')->to('default#list');
    my $type = $product->route('/:type');
    $type->get('/')->to('default#type');
    $type->get('/:id')->to('default#show');

}

1;
