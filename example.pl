#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use ForwardQueue;

%query = (
  Queue => 'MyQueue',
  States => ['new', 'open'],
  Locks => ['unlock'],
  UserID => 1,
);

%options = (
  ForwardTo => 'nobody@example.org',
  TempDir => '/tmp',
  HistoryComment => 'Forward to other request system',
  SMTP => 1,
  SMTPServer => 'smtp.example.org',
);

my $fq = ForwardQueue->new('query' => \%query, 'options' => \%options);

$fp->process_queue();
