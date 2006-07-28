package WWW::Blog::Metadata::AccountAutoDiscovery;

use strict;

use WWW::Blog::Metadata;
use HTML::AccountAutoDiscovery;

our $VERSION = '0.02';

WWW::Blog::Metadata->mk_accessors(qw(online_accounts));

sub on_got_html {
    my $class = shift;
    my($meta, $html) = @_;
    $meta->online_accounts([HTML::AccountAutoDiscovery->find_in_html($html)]);
}

sub on_got_html_order { 99 }

1;

__END__

=head1 NAME

WWW::Blog::Metadata::AccountAutoDiscovery - Extract online accounts from blogs

=head1 SYNOPSIS

  use WWW::Blog::Metadata;
  my $meta = WWW::Blog::Metadata->extract_from_uri($uri)
      or die WWW::Blog::Metadata->errstr;
  my $online_accounts = $meta->online_accounts;

  print $online_accounts->[0]{account};
  print $online_accounts->[0]{service};

=head1 DESCRIPTION

WWW::Blog::Metadata::AccountAutoDiscovery is a WWW::Blog::Metadata plugin to extract online accounts from blogs.

=head1 SEE ALSO

=item * L<WWW::Blog::Metadata>

=item * L<HTML::AccountAutoDiscovery>

=head1 AUTHOR

Kentaro Kuribayashi, E<lt>kentaro@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005, 2006 by Kentaro Kuribayashi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
