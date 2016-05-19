#!/usr/bin/env perl

use strict;
use warnings;

use feature ':5.10';

use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::DBSQL::DBConnection;

use Bio::EnsEMBL::Utils::SqlHelper;

use DBI;

my $dba = Bio::EnsEMBL::DBSQL::DBAdaptor->new(
    -user => 'root',
    -dbname => 'emmas_testing_base',
    -host => 'HAL2000',
    -pass => 'ensembl',
    -port => '3306',
);

my $helper = Bio::EnsEMBL::Utils::SqlHelper->new(
    -DB_CONNECTION => $dba->dbc()
);

if(defined $helper){
    say "hello friends helper is here";
}

my $data_source = 'dbi:mysql:database=emmas_testing_base;HAL2000;port=3306';
my $username = 'newuser';
my $pass = 'ensembl';

my $dbh = DBI->connect($data_source, $username, $pass)
    or die $DBI::errstr;
        
my $sth = $dbh->prepare("SELECT * FROM alt_allele");

my $rv = $sth->execute;

say $rv;