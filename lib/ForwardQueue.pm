package ForwardQueue;

use strict;
use warnings;

use Moose;

use lib '/var/lib/otrs/otrs-3.2.10';
use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Time;
use Kernel::System::Main;
use Kernel::System::DB;
use Kernel::System::Ticket;

our $VERSION = 0.01;

has 'options' => (is => 'ro', isa => 'HashRef');



1;