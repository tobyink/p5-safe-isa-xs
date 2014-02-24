use strict;
use warnings;
use Attribute::Benchmark;

BEGIN {
	$Safe::Isa::XS::NOREPLACE++;
};

use Safe::Isa;
use Safe::Isa::XS;
use Scalar::Util qw(blessed);

my $isa_pp = $_isa;
my $isa_xs = \&Safe::Isa::XS::_isa;

{ package Foo; use Class::Tiny };

sub isa_pp :Benchmark {
	my $obj = Foo->new;
	$obj->$isa_pp($_) for 0..4999;
}

sub isa_xs :Benchmark {
	my $obj = Foo->new;
	$obj->$isa_xs($_) for 0..4999;
}

sub isa_nowt :Benchmark {
	my $obj = Foo->new;
	blessed($obj) && $obj->isa($_) for 0..4999;
}

__END__
           Rate   isa_pp   isa_xs isa_nowt
isa_pp   20.0/s       --     -47%     -64%
isa_xs   37.8/s      89%       --     -31%
isa_nowt 55.2/s     176%      46%       --
