package MyApp::Controller::Admin::Server;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

use MyApp::Form::Server;

has 'edit_form' => (
    isa     => 'MyApp::Form::Server',
    is      => 'rw',
    lazy    => 1,
    default => sub { MyApp::Form::Server->new },
);

=head1 NAME

MyApp::Controller::Admin::Server - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub auto : Private {
    my ( $self, $c ) = @_;
    $c->stash ( bootstrap => 1);
}

sub server_base : Chained PathPart('admin/server') CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( bootstrap => 1 );
}

sub default : Chained('server_base') PathPart('') Args {
    my ( $self, $c ) = @_;
    return $self->do_list($c);
}

sub list : Chained('server_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    return $self->do_list($c);
}

sub do_list {
    my ( $self, $c ) = @_;

    my $servers = [ $c->model('DB::Server')->all ];
    my @columns = ( 'id', 'name',);
    $c->stash ( servers => $servers, columns => \@columns,
                template => 'admin/server/list.tt' );
}

sub create : Chained('server_base') PathPart('create') Args(0) {
    my ( $self, $c ) = @_;

    # Create the empty book row for the form
    my $server = $c->model('DB::Server')->new_result({});
$DB::single=1;
    $c->stash( server => $server );
    return $self->form($c);
}

sub view_server : Chained('server_base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $server_id ) = @_;

    # load server info
    my $server = $c->model('DB::Server')->find($server_id);

    $c->stash ( server => $server, );
}

sub view : Chained('view_server') PathPart('') Args(1) {
   my ( $self, $c ) = @_;
}

sub edit : Chained('view_server') PathPart('edit') Args(0) {
    my ( $self, $c ) = @_;
    return $self->form($c);
}

sub form {
    my ( $self, $c ) = @_;
    
    my $result = $self->edit_form->run(
        item    => $c->stash->{server},
        params  => $c->req->parameters,
        action  => $c->uri_for($c->action, $c->req->captures),
    );
    $c->stash( template => 'admin/server/form.tt', form => $result );
    return unless $result->validated;
    $c->res->redirect( $c->uri_for('list') );
}

sub delete : Chained('view_server') PathPart('delete') Args(0) {
    my ( $self, $c ) = @_;

   $c->stash->{server}->delete;
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
