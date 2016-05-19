#!/usr/bin/env/perl

use strict;
use warnings;

use Bio::EnsEMBL::DBSQL::DBAdaptor;
use DBUtils::CheckForOrphans;
use Logger;

my $dba = Bio::EnsEMBL::DBSQL::DBAdaptor->new(
    -user => 'newuser',
    -dbname => 'integrity_checks',
    -host => 'HAL2000',
    -driver => 'mysql',
    -pass => 'ensembl',
    -port => '3306',
);

my $helper = Bio::EnsEMBL::Utils::SqlHelper->new(
    -DB_CONNECTION => $dba->dbc()
);

my $log = Logger->new({
    healthcheck => 'test',
    type => 'core',
    species => 'homo sapiens',
});

my $result = 1;

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'assembly',
    col1 => 'asm_seq_region_id',
    table2 => 'seq_region',
    col2 => 'seq_region_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'assembly',
    col1 => 'cmp_seq_region_id',
    table2 => 'seq_region',
    col2 => 'seq_region_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'assembly_exception',
    col1 => 'seq_region_id',
    table2 => 'seq_region',
    col2 => 'seq_region_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'assembly_exception',
    col1 => 'exc_seq_region_id',
    table2 => 'seq_region',
    col2 => 'seq_region_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'dna',
    col1 => 'seq_region_id',
    table2 => 'seq_region',
    col2 => 'seq_region_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'seq_region',
    col1 => 'coord_system_id',
    table2 => 'coord_system',
    col2 => 'coord_system_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'seq_region_attrib',
    col1 => 'seq_region_id',
    table2 => 'seq_region',
    col2 => 'seq_region_id',
    constraint => '',
    both_ways => 0,
);

$result &= DBUtils::CheckForOrphans::check_orphans(
    helper => $helper,
    logger => $log,
    table1 => 'seq_region_attrib',
    col1 => 'attrib_type_id',
    table2 => 'attrib_type',
    col2 => 'attrib_type_id',
    constraint => '',
    both_ways => 0,
);

$log->result($result);