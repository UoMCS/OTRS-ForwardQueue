#!/bin/bash

# Set environment variables - required if running from cron

# If you are using local::lib
[ $SHLVL -eq 1 ] && eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# Add OTRS search libraries to the library path
PERL5LIB+="/var/lib/otrs"

# Call your Perl script here
