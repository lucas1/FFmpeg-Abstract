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

has '_video_tmp' => (
    is => 'ro',
    isa => sub {
        die 'Attribute _video_tmp is private!' unless ref($_[0]) eq 'HASH' && keys %{$_[0]} == 0
    },
    default => sub {
        {}
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

sub moov_size {
    my ($self, $value) = @_;

    push(@{$self->_video}, ' -moov_size ' . $value) if $value;
}

sub mov_flags {
    my ($self, $value) = (shift, shift);

    if ($self->_valid_mov_flags($value)) {
        push(@{$self->_video}, ' -movflags ' . $value) if $value;

        if ($value eq 'frag_keyframe') {
            push(@{$self->_video}, ' -frag_duration ' . $_[0]) if $_[0];
            push(@{$self->_video}, ' -frag_size ' . $_[1]) if $_[1];
        } elsif ($value eq 'frag_custom') {
            push(@{$self->_video}, ' -min_frag_duration ' . $_[0]) if $_[0];
        } elsif ($value eq 'default_base_moof') {
            push(@{$self->_video}, ' -write_tmcd ' . $_[0]) if $_[0];
        } elsif ($value eq 'negative_cts_offsets') {
            push(@{$self->_video}, ' -write_prft ' . $_[0]) if $_[0];
        }
    }
}

sub _valid_mov_flags {
    my $value = $_[1];

    if ($value) {
        return 1 if $value =~ /^frag_keyframe$/;
        return 1 if $value =~ /^frag_custom$/;
        return 1 if $value =~ /^empty_moov$/;
        return 1 if $value =~ /^separate_moof$/;
        return 1 if $value =~ /^skip_sidx$/;
        return 1 if $value =~ /^faststart$/;
        return 1 if $value =~ /^rtphint$/;
        return 1 if $value =~ /^disable_chpl$/;
        return 1 if $value =~ /^omit_tfhd_offset$/;
        return 1 if $value =~ /^default_base_moof$/;
        return 1 if $value =~ /^negative_cts_offsets$/;
    }

    return 0;
    
}

1;