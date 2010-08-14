package Mojolicious::Plugin::Actioncache;
use strict;

use CHI;
use Carp;
use Scalar::Util qw/blessed/;
use base qw/Mojolicious::Plugin/;

# Module implementation
#

my $cache;
my $actions;

__PACKAGE__->attr( 'driver' => 'File' );
__PACKAGE__->attr('root_dir');

sub register {
    my ( $self, $app, $conf ) = @_;

    $self->root_dir( $app->home->rel_dir('cache') );

    if ( defined $conf->{cache_actions} ) {
        $actions = { map { $_ => 1 } @{ $conf->{cache_actions} } };
    }

    #setup cache
    if ( !$cache ) {
        if ( defined $conf->{cache_object} ) {
            croak "not a CHI object\n" if !blessed $conf->{cache_object};
            $cache = $conf->{cache_object};
        }
        elsif ( defined $conf->{cache_options} ) {
            $cache = CHI->new( %{ $conf->{cache_options} } );
            if ( !$cache->driver ) {
                $cache->driver( $self->driver );
                $cache->root_dir
                    || $cache->root_dir( $self->root_dir );
            }
        }
        else {
            $cache = CHI->new(
                driver   => $self->driver,
                root_dir => $self->root_dir
            );
        }
    }

    if ( $conf->{debug} ) {
        $cache->on_set_error('log');
        $cache->on_get_error('log');
    }

    $app->plugins->add_hook(
        'before_dispatch' => sub {
            my ( $self, $c ) = @_;
            my $path = $c->tx->req->url->path->to_string;
            if ( $cache->is_valid($path) ) {
                $app->log->debug("serving from cache for $path")
                    if $conf->{debug};

                my $data = $cache->get($path);
                $c->res->code( $data->{code} );
                $c->res->headers( $data->{headers} );
                $c->res->body( $data->{body} );
                $c->stash( 'from_cache' => 1 );
            }
        }
    );

    $app->plugins->add_hook(
        'after_dispatch' => sub {
            my ( $self, $c ) = @_;
            return if $c->stash('from_cache');

            my $path = $c->url_for->path->to_string;
            my $name = $c->stash('action');

            return
                if defined $conf->{cache_actions}
                    and not exists $actions->{$name};

            $app->log->debug("storing in cache for $path and action $name")
                if $conf->{debug};
            $cache->set(
                $path,
                {   body    => $c->res->body,
                    headers => $c->res->headers,
                    code    => $c->res->code
                }
            );
        }
    );
}

1;

__END__

# ABSTRACT: Mojolicious plugin for caching response using CHI module
