package MyApp::Controller::Admin::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

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

sub list : Chained('book_base') PathPart('') Args(0) {
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

sub view_user : Chained('user_base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $user_id ) = @_;

    # load user info
    my $user = $c->model('DB::User')->find($user_id);

    # load user roles
    my $roles = join (', ', map { $_->name } $user->roles->all);

    # load user profile

    $c->stash ( user => $user, roles => $roles );
}

sub view : Chained('view_user') PathPart('') Args(1) {
   my ( $self, $c ) = @_;
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
