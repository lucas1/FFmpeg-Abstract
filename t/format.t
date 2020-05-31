use Test::More;
use FFmpeg::Abstract;

my $ffmpeg_abstract = FFmpeg::Abstract->new(
    format_input => 'mp4',
    format_output => 'mp3',
);

is($ffmpeg_abstract->command, 'ffmpeg -f mp4', 'Test path ffmpeg with format input mp4');

$ffmpeg_abstract->input('baz.mp4');
$ffmpeg_abstract->output('foo.mp3');

is($ffmpeg_abstract->command, 'ffmpeg -f mp4 -i baz.mp4 -f mp3 foo.mp3', 'Test path ffmpeg with format input mp4 and format output mp3');

$ffmpeg_abstract->output('bar.wma', 'wma');

is($ffmpeg_abstract->command, 'ffmpeg -f mp4 -i baz.mp4 -f mp3 foo.mp3 -f wma bar.wma', 'Test path ffmpeg with format input mp4 and formats output mp3 and wma');

done_testing;