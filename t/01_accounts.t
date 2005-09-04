#$Id: 01_accounts.t 15 2005-09-04 07:30:06Z kentaro $

use strict;
use Test::More tests => 4;

use WWW::Blog::Metadata;

my $meta;
my @online_accounts;
my $account_name    = 'hatena';
my $account_service = 'http://www.hatena.ne.jp/';
my $testurl         = 'http://www.hatena.ne.jp/info/perl/autodiscovery/test';

$meta            = WWW::Blog::Metadata->extract_from_uri($testurl);
@online_accounts = $meta->online_accounts;

is $online_accounts[0]->{account}, $account_name;
is $online_accounts[0]->{service}, $account_service;

my $ua   = LWP::UserAgent->new;
my $req  = HTTP::Request->new(GET => $testurl);
my $res  = $ua->request($req);
my $html = $res->content;

$meta            = WWW::Blog::Metadata->extract_from_html(\$html);
@online_accounts = $meta->online_accounts;

is $online_accounts[0]->{account}, $account_name;
is $online_accounts[0]->{service}, $account_service;
