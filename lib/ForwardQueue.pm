package ForwardQueue;

use strict;
use warnings;

use lib '/var/lib/otrs/otrs-3.2.10';
use Kernel::System::TicketSearch;

our $VERSION = 0.01;

sub new {
  my $class = shift;
  
  bless $class;
}

1;