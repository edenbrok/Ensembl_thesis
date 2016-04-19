package Logger;

use Moose;
use namespace::autoclean;

use Term::ANSIColor  qw(:constants);
$Term::ANSIColor::AUTORESET = 1;

has 'healthcheck' => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has 'type' => (
    is => 'rw',
    isa => 'Str',
    default => 'undefined',
);

has 'species' => (
    is => 'rw',
    isa => 'Str',
    default => 'undefined',
);

sub message{
    my ($self, $message) = @_;
    
    my $healthcheck = uc($self->healthcheck);
    my $type = uc($self->type);
    my $species = uc($self->species);
    
    print BRIGHT_YELLOW "$healthcheck on $type database for species: $species \t $message \n";
}

sub result{
    my ($self, $result) = @_;
    
    my $healthcheck = uc($self->healthcheck);
    my $type = uc($self->type);
    my $species = uc($self->species);
    
    if($result){
	print BRIGHT_GREEN "$result SUCCESS: $healthcheck on $type database for species $species passed succesfully \n";
    }
    else{
	print BRIGHT_RED "$result FAIL: $healthcheck on $type database for species $species failed: "
		. "please read the log to find out why. \n";
    }
    
}

#to use this to write timed runs (i.e. of a sql query):
#[before the query]
#my $total_time; [if sql is in a loop]
#use Time::HiRes qw( gettimeofday tv_interval);
#my $start_time = [gettimeofday]'
#[query]
#$total_time += tv_interval($start_time);
#[blablabla]
#$log->write_csv($filename, $total_time);
sub write_csv{
    use Text::CSV;
    my ($self, $filename, $value) = @_;
    
    my $parent_dir = File::Spec->updir;
    my $file = $parent_dir . "/$filename";
    
    open(my $fh, ">>", $file)
        or die "cannot open >> output.txt: $!";
        
    my $csv = Text::CSV->new( { binary => 1 } )
        or die "Cannot use Csv: " . Text::CSV->error_diag();
        
    my @information = ( $self->healthcheck, $value);
    my $info_ref = \@information;
    
    $csv->print($fh, $info_ref);
    print $fh "\n";
    close $fh or die "new.csv: $!";
}
1;
