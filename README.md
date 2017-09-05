# Alien::Build::Plugin::Probe::Override [![Build Status](https://secure.travis-ci.org/plicease/Alien-Build-Plugin-Probe-Override.png)](http://travis-ci.org/plicease/Alien-Build-Plugin-Probe-Override)

Override on a per-alien basis

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
`share`, `system` or `default`.  All you have to do is preload this plugin
and then provide a subroutine override, which takes a dist name (similar to
a module name, but with dashes instead of double colon).  It should return
one of:

- system

    For a system install

- share

    For a share install

- default

    Fallback on the [alienfile](https://metacpan.org/pod/alienfile) default.

- `''`

    Fallback first on `ALIEN_INSTALL_TYPE` and then on the [alienfile](https://metacpan.org/pod/alienfile) default.

# SEE ALSO

- [alienfile](https://metacpan.org/pod/alienfile)
- [Alien::Build](https://metacpan.org/pod/Alien::Build)
- [Alien::Build::Plugin::Probe::OverrideCI](https://metacpan.org/pod/Alien::Build::Plugin::Probe::OverrideCI)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
