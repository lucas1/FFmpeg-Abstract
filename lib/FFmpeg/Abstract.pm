package FFmpeg::Abstract;
use Moo;
use MooX::Const; 
use Types::Standard -types;

with qw/
    FFmpeg::Abstract::Input
    FFmpeg::Abstract::Output
    FFmpeg::Abstract::Options
/;

has 'ffmpeg' => (
    is => 'ro',
    default => 'ffmpeg'
);

has '_abbreviations' => (
    is => 'const',
    isa => ArrayRef[Str, 53],
    default => sub {
        [
            'ntsc',
            'pal',
            'qntsc',
            'qpal',
            'sntsc',
            'spal',
            'film',
            'ntsc-film',
            'sqcif',
            'qcif',
            'cif',
            '4cif',
            '16cif',
            'qqvga',
            'qvga',
            'vga',
            'svga',
            'xga',
            'uxga',
            'qxga',
            'sxga',
            'qsxga',
            'hsxga',
            'wvga',
            'wxga',
            'wsxga',
            'wuxga',
            'woxga',
            'wqsxga',
            'wquxga',
            'whsxga',
            'whuxga',
            'cga',
            'ega',
            'hd480',
            'hd720',
            'hd1080',
            '2k',
            '2kflat',
            '2kscope',
            '4k',
            '4kflat',
            '4kscope',
            'nhd',
            'hqvga',
            'wqvga',
            'fwqvga',
            'hvga',
            'qhd',
            '2kdci',
            '4kdci',
            'uhd2160',
            'uhd4320'
        ]
    }
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

sub _valid_prefix {
    my ($self, $value) = @_;

    return $value && 
           $value =~ /^\d+(?:y|z|a|f|p|n|u|m|c|d|h|k|K|M|G|T|P|E|Z|Y)$/ ? 1 : 0;
}

sub _valid_abbreviation {
    my ($self, $value) = @_;

    return $value && grep(/^$value$/, @{$self->_abbreviations}) ? 1 : 0;
}

1;