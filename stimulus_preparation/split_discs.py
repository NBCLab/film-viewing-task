# coding: utf-8
"""
Splits discs into episodes.

After that, users can use generate_split_scripts.py to split episodes into runs.
"""

import os
from os import mkdir
import os.path as op
from glob import glob
import subprocess
from shutil import copyfile

import numpy as np
import pandas as pd
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip

SPLIT_TIMES = {'S01D02': {'S01E05': (0., 3122.),
                          'S01E06':  (3122.01, 5869.),
                          'S01E07': (5869.01, 8335.),
                          'S01E08': (8335.01, 11563.)}
               }


def run(command, env={}):
    merged_env = os.environ
    merged_env.update(env)
    process = subprocess.Popen(command, stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT, shell=True,
                               env=merged_env)
    while True:
        line = process.stdout.readline()
        # line = str(line).encode('utf-8')[:-1]
        line = str(line, 'utf-8')[:-1]
        print(line)
        if line == '' and process.poll() is not None:
            break

    if process.returncode != 0:
        raise Exception("Non zero return code: {0}\n"
                        "{1}\n\n{2}".format(process.returncode, command,
                                            process.stdout.read()))


def split_video(in_file):
    mp4_file = in_file.replace('.mkv', '.mp4')
    fname = op.splitext(op.basename(in_file))[0]
    out_dir = op.dirname(in_file)
    clips_dir = out_dir
    if not op.isdir(out_dir):
        mkdir(out_dir)

    episode_split_times = SPLIT_TIMES[fname]

    if op.isdir(clips_dir):
        print('{0} exists. Skipping.'.format(clips_dir))
    else:
        mkdir(clips_dir)

    if not op.isfile(mp4_file):
        print('\n\n\nConverting to MP4\n\n\n')
        # convert video
        cmd = ('ffmpeg -i {full_mov} -q:v 1 -vcodec mpeg4 '
               '{full_mp4}').format(full_mov=in_file, full_mp4=mp4_file)
        run(cmd)

    for i_run, (run_name, split_times) in enumerate(episode_split_times.items()):
        run_file = op.join(clips_dir, '{}.mp4'.format(run_name))
        if op.isfile(run_file):
            print('Skipping {}. Already exists.'.format(run_name))
            continue

        # split
        print('Splitting video')
        dur = split_times[1] - split_times[0]
        cmd = ('ffmpeg -ss {start_time} -t {duration} -i {video_file} '
               '{clip_file}').format(
                    start_time=split_times[0],
                    duration=dur,
                    video_file=mp4_file,
                    clip_file=run_file)
        print(cmd+'\n\n\n')
        run(cmd)
        ffmpeg_extract_subclip(run_file, t1=0., t2=dur, targetname=run_file)


if __name__ == '__main__':
    in_dir = '/Users/tsalo/Desktop/diva-stimuli/'
    files = sorted(glob(op.join(in_dir, 'S01D0*.mkv')))
    files = [s for s in files if op.isfile(s)]
    for in_file in files:
        fname = op.basename(in_file)
        if not op.isfile(in_file):
            print('File not found for {0}. Skipping.'.format(fname))
        else:
            print('Running {0}'.format(fname))
            split_video(in_file)
