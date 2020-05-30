package FFmpeg::Abstract;
use Moo;
with qw/
    FFmpeg::Abstract::Input
    FFmpeg::Abstract::Output
/;

has 'ffmpeg' => (
    is => 'ro',
    default => 'ffmpeg'
);

sub command {
    my $self = shift;

    my $command = $self->ffmpeg;
    $command   .= ' -i ' . join(' -i ', @{$self->_input}) if scalar(@{$self->_input}) > 0;

    return $command;
}

1;