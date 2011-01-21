package Mojolicious::Plugin::Cache;

BEGIN {
    $Mojolicious::Plugin::Cache::VERSION = '0.001';
}

# Module implementation
#
1;

=pod

=head1 NAME

Mojolicious::Plugin::Cache - Mojolicious plugin for caching

=head1 VERSION

version 0.001

=head1 SYNOPSIS

#Mojolicious
 $self->plugin('cache-action');

#Mojolicious::Lite
  plugin 'cache-action';

=head1 DESCRIPTION

This plugin caches responses of mojolicious applications. It works by caching the entire
output of controller action for every request. Action caching internally uses
the I<before_dispatch> hook to serve the response from cache by skipping the entire
controller body. Uncached responses are cached in an I<after_dispatch> hook. 

The cache is named according to the current host and path. So,  the cache will
differentiate between an identical page that is accessed from B<tucker.myplace.com/user/2>
and from B<caboose.myplace.com/user/2> 

Different representation of the same resource such as B<tucker.myplace.com/book/list> and
B<tucker.myplace.com/book/list.json> are considered as separate requests and so are
cached separately.

=head2 Cache backends 

This plugin uses B<CHI> L<http://http://search.cpan.org/~jswartz/CHI> for caching responses.
So,  all the various cache backends and customization options of B<CHI> are supported. By
default,  this plugin uses the B<Memory>
L<http://search.cpan.org/~jswartz/CHI-0.36/lib/CHI/Driver/Memory.pm> cache backend.
Various other backends 

=over

=item *  

L<http://search.cpan.org/~jswartz/CHI-0.36/lib/CHI/Driver/File.pm|File> 

=item *

L<http://search.cpan.org/~jswartz/CHI-0.36/lib/CHI/Driver/FastMmap.pm|FastMmap>

=item *

L<http://search.cpan.org/~jswartz/CHI-Driver-Memcached-0.12/lib/CHI/Driver/Memcached.pm|Memcached>

=item *

L<http://search.cpan.org/~jswartz/CHI-Driver-BerkeleyDB-0.03/lib/CHI/Driver/BerkeleyDB.pm|BerkeleyDB>

=back

are also available through CHI.

=head2 Options

=over

=item actions

 actions => [qw/action1 action2 ....]

 #Mojolicious::Lite 
 plugin caching-actions => { cache_actions => [qw/user show/]}; 

 By default,  all actions with successful GET requests will be cached

=item options

  options =>  \%options
  All CHI module options are recognized

  #Mojolicious lite using memcache 
  plugin caching-actions => {
       options => {
       driver => 'Memcached',  
       servers => [ "10.0.0.15:11211",  "10.0.0.15:11212" ] 
     }
  } 

  #Mojolicious lite using file based storage
  plugin caching-actions => {
       options => {
       driver => 'File',  
       root_dir => '/path/to/cache' 
     }
  } 

=back

=head1 AUTHOR

Siddhartha Basu <biosidd@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Siddhartha Basu.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__

# ABSTRACT: Mojolicious plugin for caching
