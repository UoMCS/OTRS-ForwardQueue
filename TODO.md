# TODO

 * Create Bash script to set local::lib environment variables and add OTRS modules to PERL5LIB
 * Specify Perl module dependencies within the module code
 * Ensure that all required hash ref entries (options and query) are set
 * Create rollback mechanism to unlock ticket if anything fails (e.g. sending email)
 * Work out how to deal with forwarding emails when SPF is in effect - could just email user/customer to ask them to resend manually?
