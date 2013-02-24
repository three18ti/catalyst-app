#!/usr/bin/env perl
use lib 'lib';
#use MyApp;
use 5.014;
use strict;
use warnings;

use MyApp::Schema;

#my $schema = My->schema;
my $schema = MyApp::Schema->connect( 'dbi:SQLite:db/myapp.db', );

$schema->deploy({ add_drop_table => 1});

$schema->resultset('Owner')->populate([
    [ qw( id name ) ],
    [ 1, 'foo' ],
    [ 2, 'bar' ],
]);

#$schema->resultset('Server')->populate([
#    [ qw( server_id name ) ],
#    [ 1, 'one', ],
#    [ 2, 'two', ],
#    [ 3, 'three', ],
#    [ 'a-1', 'a-1.test',],
#]);

$schema->resultset('Server')->populate([
    [ qw( id name owner_id ) ],
    [ 1, 'one', 1 ],
    [ 2, 'two', 2 ],
    [ 3, 'three', 1 ],
    [ 'a-1', 'a-1.test', 1],
    [ 'a-2', 'a-2.test', 2], 
]);

$schema->resultset('Role')->delete();

$schema->resultset('Role')->populate([
    [ qw( id name ) ],
    
    [1, 'Admin' ],
    [2, 'User'  ],
    [3, 'Guest' ],
]);

$schema->resultset('User')->delete();

$schema->resultset('User')->populate([
    [ qw( id username password ) ],
    
    [1, 'test1', 'foo' ],
    [2, 'test2', 'bar' ],
    [3, 'test3', 'baz' ],
    [4, 'test4', 'stuff' ],
    [5, 'test5', 'stuff2' ],
]);

#$schema->resultset('Profile')->populate([
#    [ qw ( user_id name email ) ],

#    [1, 'Test User 1', 'test1@example.org', ],
#    [2, 'Test User 2', 'test2@example.org', ],
#    [3, 'Test User 3', 'test3@example.org', ],
#    [4, 'Test User 4', 'test4@example.org', ],
#    [5, 'Test User 5', 'test5@example.org', ],
#]);

# Passwords will be encrypted automatically
for my $user ($schema->resultset('User')->all) {
    $user->update({ password => 'test123' });
    
    $user->check_password('test123') or die 'Password check failed.';
}

my $user1 = $schema->resultset('User')->single({ id => 1 });

$user1->user_roles->delete();

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

$user1->add_role('User');

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

$user1->add_role('Admin');

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);

$user1->remove_role('User');

say "User1 roles: ", join(' ', map { $_->name } $user1->roles->all);


foreach my $user ($schema->resultset('User')->all) {
    $user->add_role('User');
    $user->create_related('profile', { name => 'Foo', email => 'foo@bar.com' });
}

foreach my $server ($schema->resultset('Server')->all) {
    say "Server: " . $server->name . " Owner: " . $server->owner->name;
}

foreach my $owner ($schema->resultset('Owner')->all) {
    say "Owner: " . $owner->name;
    say "Servers: " . join(' ', map { $_->name } $owner->servers->all);
}

exit 0;

