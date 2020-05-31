package FFmpeg::Abstract::Options;
use Moo::Role;

has '_options' => (
    is => 'ro',
    isa => sub {
        die 'Attribute _options is private!' unless ref($_[0]) eq 'ARRAY' && scalar(@{$_[0]}) == 0
    },
    default => sub {
        []
    }  
);

has 'overwrite' => (
    is => 'rw',
    isa => sub {
        die 'Attribute _options accept only 0 or 1!' unless $_[0] =~ /^(0|1)$/
    },    
    default => 0
);

1;