package MyApp::Schema::Result::Profile;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'MyApp::Schema::Result';

__PACKAGE__->table('profile');

__PACKAGE__->add_columns(
    id  => {
        data_type           => 'integer',
        size                => 16,
        is_nullable         => 0,
        is_auto_increment   => 1,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to('profile' => 'MyApp::Schema::Result::User');
