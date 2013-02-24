package MyApp::Schema::Result::Server;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'MyApp::Schema::Result';

__PACKAGE__->table('server');

__PACKAGE__->add_columns(
    id => {
        data_type => 'varchar',
        size      => 16,
        is_nullable => 0,
        is_auto_increment => 1
    },
    name => {
        data_type => 'varchar',
        size      => 256,
        is_nullable => 0,
        is_auto_increment => 0,
    },
    owner => {
        data_type   => 'varchar',
        size        => 16,
        is_nullable => 0,
    },    
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_one( 'owner' => 'MyApp::Schema::Result::Owner', { 'foreign.id' => 'self.owner' } );

__PACKAGE__->meta->make_immutable;
1;
