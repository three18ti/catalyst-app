package MyApp::Form::Server;
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

has '+item_class'       => ( default => 'Server' );

has_field 'id'    => (
    type                => 'Text',
    required            => 1,
    required_message    => 'An ID is required',
    label               => 'Server ID',
);
has_field 'name'        => (
    type                => 'Text',
    required            => 1,
    required_massage    => 'A Name is required',
    label               => 'Server Name',
);
has_field 'type'        => (
    type                => 'Select',
    label               => 'Server Type',
    label_column        => 'Type',    
);
has_field 'owner'       => (
    type                => 'Select',    
    label               => 'Owner',
    label_column        => 'name',
);

has_field submit => ( type => 'Submit', value => 'Update', element_class => ['btn'] );

__PACKAGE__->meta->make_immutable;
no HTML::FormHandler::Moose;
1;


