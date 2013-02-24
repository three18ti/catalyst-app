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
    type          => {
        data_type           => 'varchar',
        size                => 16,
        is_nullable         => 0,
        is_auto_increment   => 0,
    },
    name => {
        data_type => 'varchar',
        size      => 256,
        is_nullable => 0,
        is_auto_increment => 0,
    },
    owner_id => {
        data_type   => 'varchar',
        size        => 16,
        is_nullable => 0,
        is_foreign_key => 1,
    },    
);

__PACKAGE__->set_primary_key('id');

#__PACKAGE__->has_one( 'owner' => 'MyApp::Schema::Result::Owner', { 'foreign.id' => 'self.owner' } );
__PACKAGE__->belongs_to( 'owner' => 'MyApp::Schema::Result::Owner', 'owner_id', 
                            { join_type => 'left' } );
__PACKAGE__->belongs_to( 'server_type' => 'MyApp::Schema::Result::ServerType', 
                            { 'foreign.id' => 'self.type'},
                            { join_type => 'left' } 
);

__PACKAGE__->meta->make_immutable;
1;
