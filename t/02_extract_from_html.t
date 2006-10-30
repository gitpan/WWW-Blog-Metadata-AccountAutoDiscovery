use strict;
use FileHandle;
use Test::Base;
use WWW::Blog::Metadata::AccountAutoDiscovery;

plan tests => 4 * blocks;
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
    my $i = 0;
    for my $online_account (@{$meta->online_accounts}) {
        is $online_account->{account}, ($block->accounts)[$i];
        is $online_account->{service}, ($block->services)[$i];
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
