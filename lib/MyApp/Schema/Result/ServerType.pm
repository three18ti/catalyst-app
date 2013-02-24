package MyApp::Schema::Result::ServerType;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'MyApp::Schema::Result';

__PACKAGE__->table('server_type');

__PACKAGE__->add_columns(
    id          => {
        data_type           => 'varchar',
        size                => 16,
        is_nullable         => 0,
        is_auto_increment   => 0,
    },
    type        => {
        data_type           => 'varchar',
        size                => 256,
        is_nullable         => 0,
        is_auto_increment   => 0,
    },
    description => {
        data_type           => 'varchar',
        size                => 256,
        is_nullable         => 1,
        is_auto_increment   => 0,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->add_unique_constraint([ qw/ id / ]);

__PACKAGE__->meta->make_immutable;
1;

