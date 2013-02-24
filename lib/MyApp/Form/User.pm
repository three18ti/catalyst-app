package MyApp::Form::User;
use HTML::FormHandler::Moose;
extends 'MyApp::Form::Base';
with 'HTML::FormHandler::Widget::Theme::Bootstrap';

=head1 NAME

Form object for the User Controller

=head1 SYNOPSIS

Form used for user/add and user/edit actions

=head1 DESCRIPTION

Catalyst Form.

=cut

has '+item_class'       => ( default => 'User' );

has_field 'username'    => (
    type                => 'Text',
    required            => 1,
    required_message    => 'A Username is required',
    label               => 'Username',
);
has_field 'name'        => (
    accessor           => 'user.profile.name',
    type                => 'Text',
    required            => 1,
    required_massage    => 'A Name is required',
    label               => 'Name',
);
has_field 'email'       => (
    accessor           => 'user.profile.email',
    type                => 'Text',
    required            => 1,
    required_message    => 'An email address is required',
    label               => 'Email',
);
has_field 'password'    => (
    type                => 'Password',
    required            => 1,
    required_message    => 'A Password is required',
    label               => 'Password',
);
has_field 'roles'       => (
    type                => 'Multiple',
    label               => 'Roles',
    widget              => 'CheckboxGroup',
);

has_field submit => ( type => 'Submit', value => 'Update', element_class => ['btn'] );

__PACKAGE__->meta->make_immutable;
no HTML::FormHandler::Moose;
1;
