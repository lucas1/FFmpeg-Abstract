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

1;