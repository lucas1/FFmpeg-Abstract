package FFmpeg::Abstract;
use Moo;
with qw/
    FFmpeg::Abstract::Input
    FFmpeg::Abstract::Output
    FFmpeg::Abstract::Options
/;

has 'ffmpeg' => (
    is => 'ro',
    default => 'ffmpeg'
);

sub command {
    my $self = shift;

    my $command = $self->ffmpeg;
    $command   .= ' -f ' . $self->format_input if $self->format_input;
    $command   .= ' -i ' . join(' -i ', @{$self->_input}) if scalar(@{$self->_input}) > 0;
    $command   .= join('', @{$self->_output}) if scalar(@{$self->_output}) > 0;

    return $command;
}

sub _valid_time {
    my ($self, $value) = @_;

    if ($value) {
        return 1 if $value =~ /^\d+(\.\d+)?$/;
        return 1 if $value =~ /^\d+(ms|us)$/;
        return 1 if $value =~ /^\d{2}:\d{2}:\d{2}(\.\d+)?$/;
    }

    return 0;
}

1;