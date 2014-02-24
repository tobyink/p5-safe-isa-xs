use 5.008;
use strict qw( vars subs );
use warnings;

package Safe::Isa::XS;

use base qw( XSLoader Exporter );
use Scalar::Util qw( blessed );

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.000_01';
our @EXPORT    = qw( $_call_if_object $_isa $_can $_does $_DOES );

__PACKAGE__->load($VERSION);

for (qw( _isa _can _does _DOES )) {
	${"Safe::Isa::XS::$_"} = \&$_;
}

# Too lazy to write an XS version of this...
our $_call_if_object = sub {
	my ($obj, $method) = (shift, shift);
	return unless blessed($obj);
	return $obj->$method(@_);
};

shift our @ISA;

__END__

=pod

=encoding utf-8

=head1 NAME

Safe::Isa::XS - an XS implementation of Safe::Isa.

=head1 DESCRIPTION

Like L<Safe::Isa>, but faster.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Safe-Isa-XS>.

=head1 SEE ALSO

L<Safe::Isa>

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2014 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

