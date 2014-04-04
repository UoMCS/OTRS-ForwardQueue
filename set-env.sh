#!/bin/bash

# Set environment variables - required if running from cron

# Comment out if you are not using local::lib
[ $SHLVL -eq 1 ] && eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# Define your OTRS library path here
OTRS_LIB=""
EXTRALIBS="./lib:$OTRS_LIB"

# Add OTRS search libraries to the library path
if [ -n "$PERL5LIB" ]; then
  PERL5LIB+=":"
fi

PERL5LIB+="$EXTRALIBS"

# Call your Perl script here
