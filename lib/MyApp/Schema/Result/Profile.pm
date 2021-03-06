package MyApp::Schema::Result::Profile;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'MyApp::Schema::Result';

__PACKAGE__->table('profile');

__PACKAGE__->add_columns(
    user_id  => {
        data_type           => 'integer',
        size                => 16,
        is_foreign_key      => 1,    
        is_nullable         => 0,
    },
    
);

__PACKAGE__->set_primary_key('user_id');

# __PACKAGE__->belongs_to('profile' => 'MyApp::Schema::Result::User');
