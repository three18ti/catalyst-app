package MyApp::Schema::Result::User;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
use List::MoreUtils qw(any none);
extends 'MyApp::Schema::Result';

__PACKAGE__->table('user');

__PACKAGE__->load_components( qw( EncodedColumn ) );

__PACKAGE__->add_columns(
    id => { 
            data_type => 'integer',
            size      => 16,
            is_nullable => 0,
            is_auto_increment => 1 
    },
    username => { 
            data_type => 'varchar',
            size      => 256,
            is_nullable => 0,
            is_auto_increment => 0,
    },
);

__PACKAGE__->add_columns(   
    password => {
        data_type           => 'varchar', 
        size                => 256,
        is_nullable         => 0,
        is_auto_increment   => 0,
        encode_column       => 1,
        encode_class        => 'Crypt::Eksblowfish::Bcrypt',
        encode_args         => { key_nul => 1, cost => 8 },
        encode_check_method => 'check_password',
    },
);

__PACKAGE__->set_primary_key('id');

#__PACKAGE__->belongs_to('profile' => 'MyApp::Schema::Result::Profile');

__PACKAGE__->has_many( user_roles => 'MyApp::Schema::Result::UserRole', 'user_id' );

__PACKAGE__->many_to_many( roles => 'user_roles', 'role' );

sub add_role {
    my ($self, $name) = @_;
    
    return if any { $_->name eq $name } $self->roles->all;
    
    my $role = $self->schema->resultset('Role')->single({ name => $name });
    
    $self->add_to_user_roles({ role_id => $role->id });
}

sub remove_role {
    my ($self, $name) = @_;
    
    return if none { $_->name eq $name } $self->roles->all;
    
    my $role = $self->schema->resultset('Role')->single({ name => $name });

    $self->user_roles->search({ role_id => $role->id })->delete();
}

__PACKAGE__->meta->make_immutable;
1;

