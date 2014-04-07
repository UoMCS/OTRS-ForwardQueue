# OTRS Forward Queue

Perl module which processes a given queue in OTRS and forwards any new tickets to a given email address, then marks the tickets as resolved.

The intended use case for this module is to take tickets which have been mistakenly reported in OTRS and forward them to another ticket handling system.

## Requirements

No specific version of OTRS is required, however this software has only been tested against version 3.2.10.

### Perl modules

The following Perl modules are required:

 * IO::Interactive
 * Moose
 * namespace::autoclean
 * Email::Simple
 * Email::Sender
 