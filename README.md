# Alien::Build::Plugin::Probe::Override [![Build Status](https://secure.travis-ci.org/plicease/Alien-Build-Plugin-Probe-Override.png)](http://travis-ci.org/plicease/Alien-Build-Plugin-Probe-Override)

Override on a perl-alien basis

# SYNOPSIS

in your `~/.alienbuild/rc.pl`:

    preload 'Probe::Override';
    
    sub override {
      my($dist) = @_;
      return 'system'  if $dist eq 'Alien-gmake';
      return 'share'   if $dist eq 'Alien-FFI';
      return 'default' if $dist eq 'Alien-libuv';  # lets the alienfile choose
      return ''; # fall back on $ENV{ALIEN_INSTALL_TYPE}
    };

# DESCRIPTION

This [alienfile](https://metacpan.org/pod/alienfile) plugin allows you to override the install type (either
`share`, `system` or `default`.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
