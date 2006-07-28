use strict;
use Test::More tests => 6;

use WWW::Blog::Metadata;

my $meta;
my $online_accounts;
my $account_name     = 'hatena';
my $account_service  = 'http://www.hatena.ne.jp/';
my $testurl          = 'http://www.hatena.ne.jp/info/perl/autodiscovery/test';

# extract from online HTML
$meta            = WWW::Blog::Metadata->extract_from_uri($testurl);
$online_accounts = $meta->online_accounts;

is $online_accounts->[0]{account}, $account_name;
is $online_accounts->[0]{service}, $account_service;

# extract from HTML as string value
my $data = join '', <DATA>;
$meta = WWW::Blog::Metadata->extract_from_html(\$data);
$online_accounts = $meta->online_accounts;

is $online_accounts->[0]{account}, 'foo';
is $online_accounts->[0]{service}, 'http://foo.example.com/';
is $online_accounts->[1]{account}, 'bar';
is $online_accounts->[1]{service}, 'http://bar.example.com/';

__END__
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Test for WWW::Blog::Metadata::AccountAutoDiscovery</title>
</head>
<body>

<h1>Test for WWW::Blog::Metadata::AccountAutoDiscovery</h1>

<!--
<rdf:RDF
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:foaf="http://xmlns.com/foaf/0.1/">
<rdf:Description rdf:about="http://www.hatena.ne.jp/info/perl/autodiscovery/test">
  <foaf:maker rdf:parseType="Resource">
    <foaf:holdsAccount>
      <foaf:OnlineAccount foaf:accountName="foo">
        <foaf:accountServiceHomepage rdf:resource="http://foo.example.com/"/>
      </foaf:OnlineAccount>
    </foaf:holdsAccount>
    <foaf:holdsAccount>
      <foaf:OnlineAccount foaf:accountName="bar">
        <foaf:accountServiceHomepage rdf:resource="http://bar.example.com/"/>
      </foaf:OnlineAccount>
    </foaf:holdsAccount>
  </foaf:maker>
</rdf:Description>
</rdf:RDF>
-->

</body>
</html>
