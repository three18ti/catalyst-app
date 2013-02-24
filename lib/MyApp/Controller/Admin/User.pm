package MyApp::Controller::Admin::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

use MyApp::Form::User;

has 'edit_form' => (
    isa     => 'MyApp::Form::User',
    is      => 'rw',
    lazy    => 1,
    default => sub { MyApp::Form::User->new },
);

=head1 NAME

MyApp::Controller::Admin::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub auto : Private {
    my ( $self, $c ) = @_;
    $c->stash ( bootstrap => 1);
}

sub user_base : Chained PathPart('admin/user') CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( bootstrap => 1 );
}

sub default : Chained('user_base') PathPart('') Args {
    my ( $self, $c ) = @_;
    return $self->do_list($c);
}

sub list : Chained('user_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    return $self->do_list($c);
}

sub do_list {
    my ( $self, $c ) = @_;

    my $users = [ $c->model('DB::User')->all ];
    my @columns = ( 'username', 'email',);
    $c->stash ( users => $users, columns => \@columns,
                template => 'admin/user/list.tt' );
}

sub create : Chained('user_base') PathPart('create') Args(0) {
    my ( $self, $c ) = @_;

    # Create the empty book row for the form
    my $user = $c->model('DB::User')->new_result({});
$DB::single=1;
    $c->stash( user => $user,);
    return $self->form($c);
}

sub view_user : Chained('user_base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $user_id ) = @_;

    # load user info
    my $user = $c->model('DB::User')->find($user_id);

    # load user roles
    my $roles = join (', ', map { $_->name } $user->roles->all);

    # load user profile
    my $profile = $user->profile;

    $c->stash ( user => $user, roles => $roles, profile => $profile );
}

sub view : Chained('view_user') PathPart('') Args(1) {
   my ( $self, $c ) = @_;
}

sub edit : Chained('view_user') PathPart('edit') Args(0) {
    my ( $self, $c ) = @_;
    return $self->form($c);
}

sub form {
    my ( $self, $c ) = @_;
    
    my $result = $self->edit_form->run(
        item    => $c->stash->{user},
        params  => $c->req->parameters,
        action  => $c->uri_for($c->action, $c->req->captures),
    );
    $c->stash( template => 'admin/user/form.tt', form => $result );
    return unless $result->validated;
    $c->res->redirect( $c->uri_for('list') );
}

sub delete : Chained('view_user') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;

   $c->stash->{user}->delete;
   $c->res->redirect( $c->uri_for('list') );
}

=head2 index

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#}


=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
