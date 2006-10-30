use strict;
use Test::Base;
use WWW::Blog::Metadata::AccountAutoDiscovery;

plan tests => 2 * blocks;
filters qw(chomp);

run {
    my $block = shift;
    my $meta = WWW::Blog::Metadata->extract_from_uri($block->page_uri);
    my $online_accounts = $meta->online_accounts;
    is $online_accounts->[0]{account}, $block->account;
    is $online_accounts->[0]{service}, $block->service;
}

__END__
===
--- account
hatena
--- service
http://www.hatena.ne.jp/
--- page_uri
http://www.hatena.ne.jp/info/perl/autodiscovery/test
