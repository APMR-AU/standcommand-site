#!/bin/sh
# Cuts the hero clip, assets/demo.mp4, and its poster frame from the raw screen
# recording assets/demo-video.mov, which is gitignored and lives only on Nick's
# Mac (3 min 35 s at 2940x1612, recorded 2026-09-11 on the demonstration fair).
# The clip is never hand-edited: change the segments here and rerun. Needs
# ffmpeg. Paths are relative to this script, so it runs from anywhere.
#
# Each segment is start:end in seconds of the raw recording, and the speed it
# plays at. Six beats: reshape a stand; aisle widths and the tape; the fitout
# view, furniture, Send; the Stand Sheet, Where I am, the tape; the exhibitor
# record to its totals; the zoomed plan returning to fit.
set -e
cd "$(dirname "$0")/assets"
ffmpeg -v error -y -i demo-video.mov -filter_complex "
[0:v]trim=start=8.5:end=17.5,setpts=(PTS-STARTPTS)/1.8[v1];
[0:v]trim=start=34.5:end=38.0,setpts=PTS-STARTPTS[v2];
[0:v]trim=start=43.0:end=46.5,setpts=PTS-STARTPTS[v3];
[0:v]trim=start=75.5:end=78.5,setpts=PTS-STARTPTS[v4];
[0:v]trim=start=84.0:end=95.5,setpts=(PTS-STARTPTS)/2.5[v5];
[0:v]trim=start=96.5:end=99.0,setpts=PTS-STARTPTS[v6];
[0:v]trim=start=106.5:end=112.0,setpts=(PTS-STARTPTS)/2[v7];
[0:v]trim=start=114.0:end=116.5,setpts=PTS-STARTPTS[v8];
[0:v]trim=start=125.0:end=127.5,setpts=PTS-STARTPTS[v9];
[0:v]trim=start=161.5:end=165.5,setpts=(PTS-STARTPTS)/1.5[v10];
[0:v]trim=start=169.0:end=171.5,setpts=PTS-STARTPTS[v11];
[0:v]trim=start=188.5:end=193.0,setpts=PTS-STARTPTS[v12];
[v1][v2][v3][v4][v5][v6][v7][v8][v9][v10][v11][v12]concat=n=12:v=1:a=0,fps=30,scale=1920:-2,format=yuv420p[out]" \
  -map "[out]" -c:v libx264 -crf 23 -preset slow -movflags +faststart -an demo.mp4
ffmpeg -v error -y -i demo.mp4 -frames:v 1 -q:v 3 demo-poster.jpg
ffprobe -v error -show_entries format=duration,size:stream=width,height -of default=noprint_wrappers=1 demo.mp4
