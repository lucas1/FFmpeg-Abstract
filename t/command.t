use Test::More;
use FFmpeg::Abstract;

my $ffmpeg_abstract = FFmpeg::Abstract->new(
    ffmpeg => '/usr/bin/ffmpeg'
);

is($ffmpeg_abstract->command, '/usr/bin/ffmpeg', 'Test path ffmpeg');

$ffmpeg_abstract->input('foo.mp3');

is($ffmpeg_abstract->command, '/usr/bin/ffmpeg -i foo.mp3', 'Test path ffmpeg');

$ffmpeg_abstract->input('bar.mp3');

is($ffmpeg_abstract->command, '/usr/bin/ffmpeg -i foo.mp3 -i bar.mp3', 'Test path ffmpeg');

done_testing;