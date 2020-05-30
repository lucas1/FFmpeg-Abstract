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

sub output {
    my $self = shift;

    for (@_) {
        my $file = '';

        if ($self->path_output) {
            $file  = $self->path_output;
            $file .= '/' if $self->path_output !~ /\/$/;
        }

        $file .= $_;

        push(@{$self->_output}, $file);
    }
}

1;