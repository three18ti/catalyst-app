use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyApp';
use MyApp::Controller::Admin;

ok( request('/admin')->is_success, 'Request should succeed' );
done_testing();
