package MyApp::Schema::Result::Profile;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'MyApp::Schema::Result';

__PACKAGE__->table('profile');

__PACKAGE__->add_columns(
    user_id         => {
        data_type           => 'integer',
        size                => 16,
        is_foreign_key      => 1,    
        is_nullable         => 0,
    },
    profile_image   => {
        data_type           => 'varchar',
        size                => '256',
        is_nullable         => 1,
    },
    name    => {
            data_type => 'varchar',
            size      => 256,
            is_nullable => 0,
            is_auto_increment => 0,
    },
    email   => {
            data_type => 'varchar',
            size      => 256,
            is_nullable => 0,
            is_auto_increment => 0,
    },    
);

__PACKAGE__->set_primary_key('user_id');

#__PACKAGE__->belongs_to('profile' => 'MyApp::Schema::Result::User');

__PACKAGE__->meta->make_immutable;
1;
