package My::Primes;

use strict;
use warnings;

use Bio::EnsEMBL::Registry;

our $VERSION = 0.01;

sub is_prime {
	my $number = $_[0];
	return   if $number < 2;
	return 1 if $number == 2;
	for ( 2 .. int sqrt($number)) {
		return if !($number % $_);
	}
	return 1;
}

1;
