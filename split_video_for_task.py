# coding: utf-8
"""
Scene detection:
scenedetect --input ../S01E05.m4v --stats S01E05_stats.csv detect-content --threshold 27 list-scenes
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

SPLIT_TIMES = {'S01E01': [(5., 505.5),
                          (555.5, 968.4),
                          (968.4, 1380.26),
                          (1380.26, 1808.85),
                          (1808.5, 2275.44),
                          (2275.44, 2774.1)],
               'S01E02': [((5.5, 275.), (325., 524.05)),
                          (524.05, 897.75),
                          (897.75, 1440.55),
                          (1440.55, 1971.305),
                          (1971.305, 2412.293),
                          (2412.293, 2738.42525),
                          (2738.42525, 3179.2)],
               'S01E03': [((5.5, 121.), (171., 462.49)),
                          (462.49, 927.48),
                          (927.48, 1402.5075),
                          (1402.5075, 1940.835),
                          (1940.835, 2342.17),
                          (2342.17, 2966.)],
               'S01E04': [(5.5, 465.5),
                          (515.5, 958.2),
                          (958.2, 1397.32),
                          (1397.32, 1896.8),
                          (1896.8, 2240.9),
                          (2240.9, 2886.)],
               'S01E05': [(5.5, 495.),
                          (495., 545.),
                          (545., 986.277),
                          (986.277, 1509.425),
                          (1509.425, 1950.532),
                          (1950.532, 2462.585),
                          (2462.585, 3038.5)]}


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
    mp4_file = in_file.replace('.mov', '.mp4')
    fname = op.splitext(op.basename(in_file))[0]
    out_dir = op.dirname(in_file)
    clips_dir = op.join(out_dir, fname)
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

    for i_run, split_times in enumerate(episode_split_times[:-1]):
        run_file = op.join(clips_dir, 'uc{0}R{1:02d}.mp4'.format(fname, i_run+1))
        run_file_drc = op.join(clips_dir, '{0}R{1:02d}.mp4'.format(fname, i_run+1))
        if op.isfile(run_file):
            print('Skipping {0}R{1:02d}. Already exists.'.format(fname, i_run+1))
            continue

        if isinstance(split_times[0], tuple):
            # split and merge
            temp_files = ['temp_{}.mp4'.format(j_clip) for j_clip in range(len(split_times))]

            for j_clip, clip_split_times in enumerate(split_times):
                print('Splitting video')
                dur = clip_split_times[1] - clip_split_times[0]
                cmd = ('ffmpeg -ss {start_time} -t {duration} -i {video_file} '
                       '{clip_file}').format(
                            start_time=clip_split_times[0],
                            duration=dur,
                            video_file=mp4_file,
                            clip_file=temp_files[j_clip])
                print(cmd+'\n\n\n')
                run(cmd)

            print('Merging clips')
            with open('merge_list.txt', 'w') as fo:
                temp_str = '\n'.join(["file '{}'".format(tf) for tf in temp_files])
                fo.write(temp_str)

            cmd = 'ffmpeg -f concat -safe 0 -i merge_list.txt -c copy {}'.format(run_file)
            print(cmd+'\n\n\n')
            run(cmd)

            print('Removing temporary files')
            os.remove('merge_list.txt')
            for tf in temp_files:
                os.remove(tf)
        else:
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

        print('\n\n\nPerforming dynamic range compression\n')
        cmd = ('ffmpeg -i {clip_file} -filter_complex '
               '"[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0'
               ':-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy '
               '{cclip_file}').format(clip_file=run_file,
                                      cclip_file=run_file_drc)
        print(cmd+'\n\n\n')
        run(cmd)


if __name__ == '__main__':
    in_dir = '/Users/tsalo/Desktop/diva-stimuli/'
    files = sorted(glob(op.join(in_dir, 'S01E0*.mov')))
    files = [s for s in files if op.isfile(s)]
    for in_file in files[:4]:
        fname = op.basename(in_file)
        if not op.isfile(in_file):
            print('File not found for {0}. Skipping.'.format(fname))
        else:
            print('Running {0}'.format(fname))
            split_video(in_file)
