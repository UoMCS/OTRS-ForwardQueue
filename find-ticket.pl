#!/usr/bin/perl

use strict;
use warnings;

use lib '/var/lib/otrs/otrs-3.2.10';

use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Time;
use Kernel::System::Main;
use Kernel::System::DB;
use Kernel::System::Ticket;

my $ConfigObject = Kernel::Config->new();
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

my $ticket_id = $ARGV[0];
print "Searching for ticket ID: $ticket_id\n";

my $user_id = $ARGV[1];

my %query = (
  Result => 'COUNT',
  TicketNumber => "'$ticket_id'",
  UserID => $user_id,
);

my $results = $TicketObject->TicketSearch(%query);

print "Results: $results\n";