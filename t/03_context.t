use strict;
use FileHandle;
use Test::Base;
use WWW::Blog::Metadata::AccountAutoDiscovery;

plan tests => 5 * blocks;
filters {
    accounts => [qw(chomp eval)],
    services => [qw(chomp eval)],
    html     => 'chomp',
};

run {
    my $block = shift;

    my $fh = FileHandle->new; 
    my $html = do { local $/; $fh->open('t/sample/' . $block->html); <$fh> };
    $fh->close;

    my $meta = WWW::Blog::Metadata->extract_from_html(\$html);
    my $online_accounts_ref = $meta->online_accounts;
    my @online_accounts_ary = $meta->online_accounts;

    is_deeply $online_accounts_ref, \@online_accounts_ary;

    my $i = 0;
    for my $online_account (@{$online_accounts_ref}) {
        ok $online_account->{account}          eq ($block->accounts)[$i] &&
           $online_accounts_ary[$i]->{account} eq ($block->accounts)[$i];

        ok $online_account->{service}          eq ($block->services)[$i] &&
           $online_accounts_ary[$i]->{service} eq ($block->services)[$i];
        $i++;
    }
}

__END__
===
--- accounts
qw(foo bar)
--- services
qw(http://example.com/foo/ http://example.com/bar/)
--- html
accounts.html
