package Alien::Build::Plugin::Probe::Override;

use strict;
use warnings;
use 5.008001;
use Alien::Build::Plugin;
use Path::Tiny qw( path );

# ABSTRACT: Override on a perl-alien basis
# VERSION

sub init
{
  my($self, $meta) = @_;
  
  $meta->register_hook(
    override => sub {
      my($build) = @_;
      
      if(Alien::Build::rc->can('override'))
      {
        my $class = path($build->install_prop->{stage})->basename;
        if($class =~ /^Alien-/)
        {
          my $override = Alien::Build::rc::override($class);
          if($override)
          {
            return $override if $override =~ /^(system|share|default)$/;
            $build->log("override for $class => $override is not valid");
          }
        }
      }
      
      $ENV{ALIEN_INSTALL_TYPE} || '';
    },
  );
}

1;
