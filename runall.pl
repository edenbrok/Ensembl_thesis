#!usr/bin/env perl

use strict;
use warnings;

my %healthchecks = (
    1 => '1-integrity/CoreForeignKeys.pl',
    2 => '2-integrity/AssemblyMapping.pl',
    3 => '2-integrity/LRG.pl',
    4 => '2-integrity/ProjectedXrefs.pl',
    5 => '2-integrity/SeqRegionCoordSystem.pl',
    6 => '2-integrity/SequenceLevel.pl',
    7 => '2-integrity/XrefTypes.pl',
    8 => '3-sanity/AutoIncrement.pl',
    9 => '3-sanity/Meta.pl',
    10 => '4-sanity/AssemblyNameLength.pl',
    11 => '4-sanity/DataFiles.pl',
    12 => '5-comparison/CoordSystemAcrossSpecies.pl',
);

my $cmd;

for my $no (keys %healthchecks){

    $cmd = "perl $healthchecks{$no} --config_file 'config'";
    
    system($cmd);
}