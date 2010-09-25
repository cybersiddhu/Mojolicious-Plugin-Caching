package Mojolicious::Plugin::Caching::Actions;

use strict;
use warnings;
use CHI;
use Carp;
use Scalar::Util qw/blessed/;
use base qw/Mojolicious::Plugin/;

# Module implementation
#

my $cache;
my $actions;

__PACKAGE__->attr( 'driver' => 'Memory' );

sub register {
    my ( $self, $app, $conf ) = @_;

    if ( defined $conf->{cache_actions} ) {
        $actions = { map { $_ => 1 } @{ $conf->{cache_actions} } };
    }

    #setup cache
    if ( !$cache ) {
        if ( defined $conf->{cache_options} ) {
            my $opt = $conf->{cache_options};
            $opt->{driver} = $self->driver if not defined $opt->{driver};
            $cache = CHI->new(%$opt);
        }
        else {
            $cache = CHI->new(
                driver   => $self->driver
            );
        }
    }

    if ( $app->log->level eq 'debug' ) {
        $cache->on_set_error('log');
        $cache->on_get_error('log');
    }

    $app->plugins->add_hook(
        'before_dispatch' => sub {
            my ( $self, $c ) = @_;
            my $path = $c->tx->req->url->to_abs->to_string;
            $app->log->debug( ref $path );
            if ( $cache->is_valid($path) ) {
                $app->log->debug("serving from cache for $path");
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

            #conditions at which no caching will be done
            ## - it is already a cached response
            return if $c->stash('from_cache');

            ## - has to be GET request
            return if $c->req->method ne 'GET';

            ## - only successful response
            return if $c->res->code != 200;

            my $path = $c->req->url->to_abs->to_string;
            my $name = $c->stash('action');

            ## - have to match the action
            return
                if defined $conf->{cache_actions}
                    and not exists $actions->{$name};

            $app->log->debug("storing in cache for $path and action $name");
            $cache->set(
                $path,
                {   body    => $c->res->body,
                    headers => $c->res->headers,
                    code    => $c->res->code
                }
            );
        }
    );

    return;
}

1;

__END__

# ABSTRACT: Mojolicious plugin for caching


=head1 SYNOPSIS

#Mojolicious
 $self->plugin('caching-actions');

#Mojolicious::Lite
  plugin 'caching-actions';


=head1 DESCRIPTION

This plugin caches responses of mojolicious applications. It works by caching the entire
output of controller action for every request that goes through it. Action caching internally uses
the I<before_dispatch> hook to serve the response if cache is present and the entire
controller body is skipped. If absent the output is cached in an I<after_dispatch> hook. 

The cache is named according to the current host and path. So,  the cache will
differentiate between an identical page that is accessed from B<tucker.myplace.com/user/2>
and from B<caboose.myplace.com/user/2> 

Different representation of the same resource such as B<tucker.myplace.com/book/list> and
B<tucker.myplace.com/book/list.json> are considered as separate requests and so are
cached separately.


=head2 Backend 

This plugin uses L<http://http://search.cpan.org/~jswartz/CHI|CHI> for caching responses.
So,  all the various cache backends and customization options are supported here. By
default,  this plugin uses the B<Memory> cache backend.

=head2 Options

=over

=item cache_actions

 cache_actions => [qw/action1 action2 ....]

 #Mojolicious::Lite 
 plugin caching-actions => { cache_actions => [qw/user show/]}; 

 By default,  all actions with successful GET requests will be cached
 
=item cache_options

  cache_options =>  \%options
  All CHI module options are recognized

  #Mojolicious lite using memcache 
  plugin caching-actions => {
     cache_options => {
       driver => 'Memcached',  
       servers => [ "10.0.0.15:11211",  "10.0.0.15:11212" ] 
     }
  } 

  #Mojolicious lite using file based storage
  plugin caching-actions => {
     cache_options => {
       driver => 'File',  
       root_dir => '/path/to/cache' 
     }
  } 


  By default,  the B<Memory> driver is used.

=back


