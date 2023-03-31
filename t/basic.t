use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new( 'Postnr' );

$t->get_ok( '/7633'  )->status_is( 200 );
$t->get_ok( '/76331' )->status_is( 400 );
$t->get_ok( '/7636'  )->status_is( 404 );

done_testing;
