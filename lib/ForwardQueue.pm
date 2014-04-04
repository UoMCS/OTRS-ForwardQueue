package ForwardQueue;

use strict;
use warnings;

use Moose;
use namespace::autoclean;

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
    get_query => 'get',
    set_query => 'set',
  },
);

has 'options' => (
  traits => ['Hash'],
  is => 'rw',
  isa => 'HashRef',
  required => 1,
  handles => {
    get_option => 'get',
    exists_option => 'exists',
    defined_option => 'defined',
  },
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
  
  foreach my $ticket_id (@results)
  {
    print "Processing ticket ID: $ticket_id\n";
  
    # Lock ticket before proceeding, to prevent other users from accessing it
    my $lock_success = $TicketObject->TicketLockSet(
	  Lock => 'lock',
	  TicketID => $ticket_id,
	  UserID => $self->get_query('UserID'),
	  SendNoNotification => 1,
	);
	
	# Log the change in the history
	my $history_success = $TicketObject->HistoryAdd(
	  Name => $self->get_option('HistoryComment'),
	  HistoryType => 'Misc',
	  TicketID => $ticket_id,
	  CreateUserID => $self->get_query('UserID'),
	);
	
	# Mark the ticket as successfully closed
	my $close_success = $TicketObject->TicketStateSet(
	  State => 'closed successful',
	  TicketID => $ticket_id,
	  UserID => $self->get_query('UserID'),
	  SendNoNotifications => 1,
	);
  }
}

__PACKAGE__->meta->make_immutable;

1; # Magic true value required at end of module
__END__

=head1 NAME

ForwardQueue - Forwards the contents of an OTRS queue to a given email address.

=head1 VERSION

This document describes ForwardQueue version 0.0.1.

=head1 SYNOPSIS


=head1 DESCRIPTION

This module queries the Open Technology Real Services (OTRS) ticket management
system for ticketss matching the query provided and then forwards these
tickets to an email address, closing them in OTRS.

The original motivation for writing this module was to re-assign tickets
which were reported in the incorrect system.

=head1 DEPENDENCIES

This module requires the following modules:

=over 4

=item C<IO::Interactive>
=item C<Moose>
=item C<namespace::autoclean>

=back