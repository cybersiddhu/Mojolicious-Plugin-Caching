use Test::More qw/no_plan/;
use Test::Mojo;
use File::Path qw/remove_tree/;
use CHI;
use File::Spec::Functions;
use Module::Build;
use FindBin;
use lib "$FindBin::Bin/lib/book/lib";

BEGIN {
    $ENV{MOJO_LOG_LEVEL} ||= 'fatal';
}

my $build     = Module::Build->current;
my $cache_dir = catdir( $build->base_dir, 't', 'tmp', 'cache' );
my $cache     = CHI->new( root_dir => $cache_dir, driver => 'File' );

use_ok('Book');
my $test = Test::Mojo->new( app => 'Book' );
$test->get_ok('/books')->status_is(200)->content_is('books');
is( $cache->is_valid('/books'), 1, 'it has cached /books url' );

$test->get_ok('/book')->status_is(404);
isnt( $cache->is_valid('/book'),
    1, 'it has not cached /book with 404 response code' );

#cleanup
END {
remove_tree( catdir( $build->base_dir, 't', 'tmp' ) );
}

