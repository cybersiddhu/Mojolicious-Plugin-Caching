package User;

use strict;
use base 'Mojolicious';
use File::Spec::Functions;
use Module::Build;

# This method will run once at server start
sub startup {
    my $self = shift;

    # Routes
    my $r = $self->routes;

    my $build = Module::Build->current;
    my $cache_dir = catdir( $build->base_dir, 't', 'tmp', 'cache' );

    $self->plugin(
        'cache-action',
        {   options => {
                root_dir  => $cache_dir,
                namespace => 'user',
                driver    => 'File'
            },
            actions => [qw/users show/]
        }
    );

    $r->route('/user')->via('post')->to('controller-cache#add');
    $r->route('/user/:id')->via('delete')->to('controller-cache#remove_user');
    my $books = $r->route('/user');
    $books->get('/')->to('controller-cache#users');
    my $more = $books->route('/:id');
    $more->get('/')->to('controller-cache#show');
    $more->get('/email')->to('controller-cache#email');
    $more->get('/name')->to('controller-cache#name');
}

1;
