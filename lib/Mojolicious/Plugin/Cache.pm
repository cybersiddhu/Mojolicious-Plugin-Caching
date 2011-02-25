package Mojolicious::Plugin::Cache;

BEGIN {
    $Mojolicious::Plugin::Cache::VERSION = '0.0011';
}

# Module implementation
#
1;

=pod

=head1 NAME

Mojolicious::Plugin::Cache - Mojolicious plugin for caching

=head1 VERSION

version 0.0011

=head1 SYNOPSIS

# Action caching
## Mojolicious

$self->plugin('cache-action');

## Mojolicious::Lite

plugin 'cache-action';

# Page caching
## Mojolicious

$self->plugin('cache-page');

## Mojolicious::Lite

plugin 'cache-page'

=head1 DESCRIPTION

This distribution provides two plugins to cache responses of mojolicious applications,  action-caching
and page-caching. 

=over

=item *

L<Mojolicious::Plugin::Cache::Action|Action caching>

B<Action caching> works by caching the entire response of controller action for every
requrest. For more read L<Mojolicious::Plugin::Cache::Action|here ...>

=item *

L<Mojolicious::Plugin::Cache::Page|Page caching>

B<Page caching> works by caching the controller response in a HTML file which can be
served directly by webserver bypassing the controller altogether. For more read here
L<Mojolicious::Plugin::Cache::Page|here ...>

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
