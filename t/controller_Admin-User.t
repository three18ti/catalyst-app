use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyApp';
use MyApp::Controller::Admin::User;

ok( request('/admin/user')->is_success, 'Request should succeed' );
done_testing();
