package ForwardQueue;

use strict;
use warnings;

use Moose;
use namespace::autoclean;

use lib '/var/lib/otrs/otrs-3.2.10';
use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Time;
use Kernel::System::Main;
use Kernel::System::DB;
use Kernel::System::Ticket;

our $VERSION = 0.01;

has 'query' => (
  traits => ['Hash'],
  is => 'rw',
  isa => 'HashRef',
  required => 1,
  handles => {
    set_query => 'set',
  },
);

has 'options' => (
  traits => ['Hash'],
  is => 'rw',
  isa => 'HashRef',
  required => 1,
  handles > {
    get_option => 'get',
    exists_option => 'exists',
    defined_option => 'defined',
  }.
);

sub process_queue
{
  my $self = shift;

  # Create all objects necessary for searching tickets
  my $ConfigObject = Kernel::Config->new();

  if ($self->exists_option('TempDir') && $self->defined_option('TempDir'))
  {
    $ConfigObject->Set( Key => 'TempDir', Value => $self->get_option('TempDir') );
  }

  my $EncodeObject = Kernel::System::Encode->new(
    ConfigObject => $ConfigObject,
  );

  my $LogObject = Kernel::System::Log->new(
    ConfigObject => $ConfigObject,
    EncodeObject => $EncodeObject,
  );

  my $TimeObject = Kernel::System::Time->new(
    ConfigObject => $ConfigObject,
    LogObject    => $LogObject,
  );

  my $MainObject = Kernel::System::Main->new(
    ConfigObject => $ConfigObject,
    EncodeObject => $EncodeObject,
    LogObject    => $LogObject,
  );

  my $DBObject = Kernel::System::DB->new(
    ConfigObject => $ConfigObject,
    EncodeObject => $EncodeObject,
    LogObject    => $LogObject,
    MainObject   => $MainObject,
  );

  my $TicketObject = Kernel::System::Ticket->new(
    ConfigObject       => $ConfigObject,
    LogObject          => $LogObject,
    DBObject           => $DBObject,
    MainObject         => $MainObject,
    TimeObject         => $TimeObject,
    EncodeObject       => $EncodeObject,
  );  
  
  $self->set_query('Result' => 'ARRAY');
  
  my @results = $TicketObject->TicketSearch(%{$self->query});
}

__PACKAGE__->meta->make_immutable;

1;