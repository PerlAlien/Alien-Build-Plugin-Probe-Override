package Alien::Build::Plugin::Probe::Override;

use strict;
use warnings;
use 5.008001;
use Alien::Build::Plugin;
use Path::Tiny qw( path );

# ABSTRACT: Override on a perl-alien basis
# VERSION

=head1 SYNOPSIS

in your C<~/.alienbuild/rc.pl>:

 preload 'Probe::Override';
 
 sub override {
   my($dist) = @_;
   return 'system'  if $dist eq 'Alien-gmake';
   return 'share'   if $dist eq 'Alien-FFI';
   return 'default' if $dist eq 'Alien-libuv';  # lets the alienfile choose
   return ''; # fall back on $ENV{ALIEN_INSTALL_TYPE}
 };

=head1 DESCRIPTION

This L<alienfile> plugin allows you to override the install type (either
C<share>, C<system> or C<default>.

=cut

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
