#!/usr/bin/env perl

use strict;
use warnings;

use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Utils::SqlHelper;

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

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM assembly_audit"
        . " WHERE asm_seq_region_id NOT IN"
        . " (SELECT seq_region_id FROM seq_region)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM assembly_audit"
        . " WHERE cmp_seq_region_id NOT IN"
        . " (SELECT seq_region_id FROM seq_region)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM assembly_exception_audit"
        . " WHERE seq_region_id NOT IN"
        . " (SELECT seq_region_id FROM seq_region)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM assembly_exception_audit"
        . " WHERE exc_seq_Region_id NOT IN"
        . " (SELECT seq_region_id FROM seq_region)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM dna_audit"
        . " WHERE sequence_region_id NOT IN"
        . " (SELECT seq_region_id FROM seq_region)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM seq_region_audit"
        . " WHERE coord_system_id NOT IN"
        . " (SELECT coord_system_id FROM coord_system)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM seq_region_attrib_audit"
        . " WHERE seq_region_id NOT IN"
        . " (SELECT seq_region_id FROM seq_region)"
);

$helper->execute(
    -SQL => "SELECT SQL_NO_CACHE COUNT(*) FROM seq_region_attrib_audit"
        . " WHERE attrib_type_id NOT IN"
        . " (SELECT attrib_type_id FROM attrib_type)"
);