package Mojolicious::Plugin::Cache;

# Module implementation
#
1;

__END__

# ABSTRACT: Mojolicious plugin for caching


=head1 SYNOPSIS

#Action caching
  ## Mojolicious
  $self->plugin('cache-action');

  ##Mojolicious::Lite
  plugin 'cache-action';

#Page caching
 ## Mojolicious
 $self->plugin('cache-page');

##Mojolicious::Lite
 plugin 'cache-page'
	
	


=head1 DESCRIPTION

This distribution provides two plugins to cache responses of mojolicious applications,  action-caching
and page-caching. 

=over

=item *

L<Action caching|Mojolicious::Plugin::Cache::Action>

B<Action caching> works by caching the entire response of controller action for every
requrest. For more read L<here|Mojolicious::Plugin::Cache::Action>

=item *

L<Page caching|Mojolicious::Plugin::Cache::Page>

B<Page caching> works by caching the controller response in a HTML file which can be
served directly by webserver bypassing the controller altogether. For more read 
L<here|Mojolicious::Plugin::Cache::Page>

=back


