use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'WWW::Blog::Metadata::AccountAutoDiscovery',
    VERSION_FROM      => 'lib/WWW/Blog/Metadata/AccountAutoDiscovery.pm',
    PREREQ_PM         => {
        WWW::Blog::Metadata        => 0.02,
        HTML::AccountAutoDiscovery => 0.06,
    },
);
