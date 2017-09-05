package Alien::Build::Plugin::Probe::Override;

use strict;
use warnings;
use 5.008001;
use Alien::Build::Plugin;
use Path::Tiny qw( path );

# ABSTRACT: Override on a per-alien basis
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
C<share>, C<system> or C<default>) on a per-Alien basis.  All you have to
do is preload this plugin and then provide a subroutine override, which
takes a dist name (similar to a module name, but with dashes instead of
double colon).  It should return one of:

=over 4

=item system

For a system install

=item share

For a share install

=item default

Fallback on the L<alienfile> default.

=item C<''>

Fallback first on C<ALIEN_INSTALL_TYPE> and then on the L<alienfile> default.

=back

=head1 SEE ALSO

=over 4

=item L<alienfile>

=item L<Alien::Build>

=item L<Alien::Build::Plugin::Probe::OverrideCI>

=back

=cut

sub init
{
  my($self, $meta) = @_;
  
  $meta->register_hook(
    override => sub {
      my($build) = @_;

      if(Alien::Build::rc->can('override'))
      {
        foreach my $try (qw( stage prefix ))
        {
          my $class = path($build->install_prop->{$try})->basename;
          if($class =~ /^Alien-/)
          {
            my $override = Alien::Build::rc::override($class);
            if($override)
            {
              if($override =~ /^(system|share|default)$/)
              {
                $build->log("ovveride for $class => $override");
                return $override;
              }
              else
              {
                $build->log("override for $class => $override is not valid");
              }
            }
          }
        }
      }
      
      $ENV{ALIEN_INSTALL_TYPE} || '';
    },
  );
}

1;
