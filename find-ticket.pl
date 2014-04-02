#!/usr/bin/perl

use strict;
use warnings;

use lib '/var/lib/otrs/otrs-3.2.10';
use Kernel::System::TicketSearch;

my $ticket_id = $ARGV[0];

my %query = (
  Result => 'ARRAY',
  TicketID => $ticket_id,
);

my @results = Kernel::System::TicketSearch::TicketSearch(%query);

print @results . "\n";
