package FFmpeg::Abstract::Output;
use Moo::Role;

has '_output' => (
    is => 'ro',
    isa => sub {
        die 'Attribute _output is private!' unless ref($_[0]) eq 'ARRAY' && scalar(@{$_[0]}) == 0
    },
    default => sub {
        []
    }  
);

has 'path_output' => (
    is => 'ro'
);

# force format output
has 'format_output' => (
    is => 'ro'
);

sub output {
    my ($self, $value, $format) = @_;

    my $file = ($format || $self->format_output) ? ' -f ' . ($format || $self->format_output) . ' ' : '';

    if ($self->path_output) {
        $file  = $self->path_output;
        $file .= '/' if $self->path_output !~ /\/$/;
    }

    $file .= $value;

    push(@{$self->_output}, $file);
}

sub t_output {
    my ($self, $value) = @_;

    if ($self->_valid_time($value)) {
        
    }
}

sub to_output {
    my ($self, $value) = @_;

    if ($self->_valid_time($value)) {

    }
}

sub ss_output {
    my ($self, $value) = @_;

    if ($self->_valid_time($value)) {
        
    }
}

1;