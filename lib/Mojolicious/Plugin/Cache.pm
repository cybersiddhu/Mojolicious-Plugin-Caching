package Mojolicious::Plugin::Cache;

# Module implementation
#
1;

__END__

# ABSTRACT: Mojolicious plugin for caching


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


