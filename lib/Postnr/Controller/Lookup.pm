package Postnr::Controller::Lookup;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub index ($self) {
  my $postnr = $self->param( 'postnr' ) // '';

  unless ( $postnr =~ m/^(\d\d\d\d)$/ ) {
    return $self->_render_error( 400, 'Bad request; input parameter must be 4 digits long!' );
  }

  my $data = $self->postnr->{$postnr};

  unless ( $data ) {
    return $self->_render_error( 404, $postnr . ' was not found!' );
  }

  return $self->render(
    'status' => 200,
    'json'   => $data,
  );
}

sub _render_error ($self, $status_code, $error) {
  return $self->render(
    'status' => $status_code,
    'json'   => {
      'error' => $error // 'Unknown error',
    },
  );
}

1;
