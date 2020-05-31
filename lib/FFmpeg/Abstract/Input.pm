package FFmpeg::Abstract::Input;
use Moo::Role;

has '_input' => (
    is => 'ro',
    isa => sub {
        die 'Attribute _input is private!' unless ref($_[0]) eq 'ARRAY' && scalar(@{$_[0]}) == 0
    },
    default => sub {
        []
    }  
);

has 'path_input' => (
    is => 'ro'
);

# force format input
has 'format_input' => (
    is => 'ro'
);

sub input {
    my $self = shift;

    for (@_) {
        my $file = '';

        if ($self->path_input) {
            $file  = $self->path_input;
            $file .= '/' if $self->path_input !~ /\/$/;
        }

        $file .= $_;

        push(@{$self->_input}, $file);
    }
}

sub t_input {
    my ($self, $value) = @_;

    if ($self->_valid_time($value)) {
        
    }
}

sub to_input {
    my ($self, $value) = @_;

    if ($self->_valid_time($value)) {

    }
}

sub ss_input {
    my ($self, $value) = @_;

    if ($self->_valid_time($value)) {
        
    }
}

1;