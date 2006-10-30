use strict;
use Test::More;
eval q{ use Test::Pod };
plan skip_all => 'Test::Pod required for testing POD' if $@;
all_pod_files_ok();
