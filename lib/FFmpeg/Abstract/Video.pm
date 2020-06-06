package FFmpeg::Abstract::Video;
use Moo::Role;

has '_video' => (
    is => 'ro',
    isa => sub {
        die 'Attribute _video is private!' unless ref($_[0]) eq 'ARRAY' && scalar(@{$_[0]}) == 0
    },
    default => sub {
        []
    }  
);

sub video_bitrate {
    my ($self, $value) = @_;

    push(@{$self->_video}, ' -b:v ' . $value) if $self->_valid_prefix($value);
}

sub video_min_rate {
    my ($self, $value) = @_;

    push(@{$self->_video}, ' -minrate ' . $value) if $self->_valid_prefix($value);
}

sub video_max_rate {
    my ($self, $value) = @_;

    push(@{$self->_video}, ' -maxrate ' . $value) if $self->_valid_prefix($value);
}

sub video_buf_size {
    my ($self, $value) = @_;

    push(@{$self->_video}, ' -bufsize ' . $value) if $self->_valid_prefix($value);
}

1;