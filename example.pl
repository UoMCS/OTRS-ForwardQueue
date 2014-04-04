#!/usr/bin/perl

use strict;
use warnings;

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
);