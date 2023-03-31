package Postnr;
use Mojo::Base 'Mojolicious', -signatures;

use Mojo::Util qw( trim );

# This method will run once at server start
sub startup ($self) {
  # Load configuration from config file
  my $config = $self->plugin( 'NotYAMLConfig' );

  # Prepare data
  $self->_prepare_data;

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get( '/:postnr' )->to( 'Lookup#index' );

  # Done?
  if ( $self->postnr->{'7633'} ) {
    $self->log->debug( 'Application started successfully with ' . scalar(keys %{$self->postnr}) . ' postal codes!' );
  }
  else {
    $self->log->error( 'Failed to start application because of missing data!' );
    die;
  }
}

# Creates a helper out of Bring's data
sub _prepare_data ($self) {
  my $data  = $self->ua->get( $self->config->{'bring_url'} )->res->body;
  my @lines = map { trim($_) } split( /\n+/, $data );

  my %postnr = ();

  foreach ( @lines ) {
    my @fields = split( /\t+/, $_ );

    $postnr{ $fields[0] } = {
      'postnummer'  => $fields[0],
      'poststed'    => $fields[1],
      'kommunekode' => $fields[2],
      'kommunenavn' => $fields[3],
      'kategori'    => $fields[4],
    };
  }

  $self->helper( 'postnr' => sub ($self) {
    return \%postnr;
  } );
}

1;
