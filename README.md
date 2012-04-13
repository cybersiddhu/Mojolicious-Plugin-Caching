# NAME

Mojolicious::Plugin::Cache - Mojolicious plugin for caching

# VERSION

version 0.0017

# SYNOPSIS

Action caching:

    plugin 'cache-action';
    $self->plugin('cache-action');

Page caching:

    plugin 'cache-page'
    $self->plugin('cache-page');

# DESCRIPTION

This distribution provides two plugins to cache responses of mojolicious applications,  action-caching
and page-caching. 

- [Action caching](http://search.cpan.org/perldoc?Mojolicious::Plugin::Cache::Action)

__Action caching__ works by caching the entire response of controller action for every
requrest. For more read [here](http://search.cpan.org/perldoc?Mojolicious::Plugin::Cache::Action)

- [Page caching](http://search.cpan.org/perldoc?Mojolicious::Plugin::Cache::Page)

__Page caching__ works by caching the controller response in a HTML file which can be
served directly by webserver bypassing the controller altogether. For more read 
[here](http://search.cpan.org/perldoc?Mojolicious::Plugin::Cache::Page)

# AUTHOR

Siddhartha Basu <biosidd@gmail.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Siddhartha Basu.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.