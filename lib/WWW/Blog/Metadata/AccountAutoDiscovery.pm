package WWW::Blog::Metadata::AccountAutoDiscovery;

use strict;

use WWW::Blog::Metadata;
use HTML::AccountAutoDiscovery;

our $VERSION = '0.03';

WWW::Blog::Metadata->mk_accessors(qw(_online_accounts));

sub on_got_html {
    my $class = shift;
    my($meta, $html) = @_;
    $meta->_online_accounts([HTML::AccountAutoDiscovery->find_in_html($html)]);
}

sub WWW::Blog::Metadata::online_accounts {
    my $self = shift;
    wantarray ? @{$self->_online_accounts || []} : $self->_online_accounts;
}

sub on_got_html_order { 99 }

1;

__END__

=head1 NAME

WWW::Blog::Metadata::AccountAutoDiscovery - Extract online accounts
from a page

=head1 SYNOPSIS

  use WWW::Blog::Metadata;
  my $meta = WWW::Blog::Metadata->extract_from_uri($uri)
      or die WWW::Blog::Metadata->errstr;

  ## or

  my $meta = WWW::Blog::Metadata->extract_from_html(\$html)
      or die WWW::Blog::Metadata->errstr;

  # in scalar context, returns an array-ref
  my $online_accounts_ref = $meta->online_accounts;
  print $online_accounts->[0]{account};
  print $online_accounts->[0]{service};

  # in list context, returns an array
  my @online_accounts_array = $meta->online_accounts;
  print $online_accounts_array[0]->{account};
  print $online_accounts_array[0]->{service};

=head1 DESCRIPTION

WWW::Blog::Metadata::AccountAutoDiscovery is a WWW::Blog::Metadata
plugin to look for and extract online accounts embedded in a page.

=head1 METHODS

=head2 online_accounts

=over 4

  # in scalar context, returns an array-ref
  my $online_accounts_ref = $meta->online_accounts;
  print $online_accounts->[0]{account};
  print $online_accounts->[0]{service};

  # in list context, returns an array
  my @online_accounts_array = $meta->online_accounts;
  print $online_accounts_array[0]->{account};
  print $online_accounts_array[0]->{service};

Extracts and returns online accounts embedded in the specified page.

The return value consists of hash-refs which contain two fields,
account and service.

=back

=head1 SEE ALSO

=over 4

=item * L<WWW::Blog::Metadata>

You might as well consult the documentaion of WWW::Blog::Metadata for
more usage.

=item * L<HTML::AccountAutoDiscovery>

WWW::Blog::Metadata::AccountAutoDiscovery only delegates the job
wholly to HTML::AccountAutoDiscovery.

=back

=head1 AUTHOR

Kentaro Kuribayashi, E<lt>kentaro@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE (The MIT License)

Copyright (c) 2006, Kentaro Kuribayashi E<lt>kentaro@cpan.orgE<gt>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut
