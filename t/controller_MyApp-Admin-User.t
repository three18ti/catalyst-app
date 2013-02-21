use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyApp';
use MyApp::Controller::MyApp::Admin::User;

ok( request('/myapp/admin/user')->is_success, 'Request should succeed' );
done_testing();
