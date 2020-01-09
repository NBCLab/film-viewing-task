# coding: utf-8
"""
Generate shell scripts that call ffmpeg to convert and split video files.

Scene detection:
scenedetect --input ../S01E05.mp4 --stats S01E05_stats.csv detect-content --threshold 27 list-scenes

Singularity image built with the following command because later versions failed on HPC:
singularity build ffmpeg.sif docker://jrottenberg/ffmpeg:3.3-alpine
"""

import os
from os import mkdir
import os.path as op
import json
from glob import glob
import subprocess
from shutil import copyfile
import argparse

import numpy as np
import pandas as pd


def _get_parser():
    """
    Parses command line inputs for tedana

    Returns
    -------
    parser.parse_args() : argparse dict
    """
    parser = argparse.ArgumentParser()
    parser.add_argument(
        dest='episode_file',
        help='Video file to split',
        required=True
    )
    parser.add_argument(
        dest='output_dir',
        help='Output directory',
        required=False
    )
    return parser


def build_script(episode_file, output_dir=None):
    """
    Split a single episode file based on split times in a json file
    (split_times.json).
    """
    with open('split_times.json', 'r') as fo:
        split_times = json.read(fo)

    mp4_file = episode_file.replace('.mp4', '.mp4')
    fname = op.splitext(op.basename(episode_file))[0]
    if output_dir is None:
        out_dir = op.dirname(episode_file)
    else:
        out_dir = output_dir
    clips_dir = op.join(out_dir, fname)
    if not op.isdir(out_dir):
        mkdir(out_dir)

    episode_split_times = split_times[fname]
    script = ''

    if op.isdir(clips_dir):
        print('{0} exists. Skipping.'.format(clips_dir))
    else:
        mkdir(clips_dir)

    if not op.isfile(mp4_file):
        print('\n\n\nConverting to MP4\n\n\n')
        # convert video
        cmd = ('ffmpeg -i {episode_file} -q:v 1 -vcodec mpeg4 '
               '{mp4_file}').format(
                    episode_file=episode_file, mp4_file=mp4_file)
        script += cmd + '\n\n'

    for i_run, split_times in enumerate(episode_split_times):
        # Run-wise split file
        run_file_nondrc = op.join(clips_dir, 'nondrc_{0}R{1:02d}.mp4'.format(fname, i_run+1))
        # Run-wise split file after dynamic range compression
        run_file_drc = op.join(clips_dir, 'drc_{0}R{1:02d}.mp4'.format(fname, i_run+1))
        # Run-wise split file after dynamic range compression and downsampling
        run_file_final = op.join(clips_dir, '{0}R{1:02d}.mp4'.format(fname, i_run+1))
        if op.isfile(run_file_final):
            print('Skipping {0}R{1:02d}. Already exists.'.format(fname, i_run+1))
            continue

        if isinstance(split_times[0], tuple) and not op.isfile(run_file_nondrc):
            # split and merge
            temp_files = [op.join(clips_dir, 'temp_{}.mp4'.format(j_clip))
                          for j_clip in range(len(split_times))]

            for j_clip, clip_split_times in enumerate(split_times):
                print('Splitting video')
                dur = clip_split_times[1] - clip_split_times[0]
                cmd = ('ffmpeg -ss {start_time} -i {video_file} -t {duration} '
                       '{clip_file}').format(
                            start_time=clip_split_times[0], duration=dur,
                            video_file=mp4_file, clip_file=temp_files[j_clip])
                script += cmd + '\n\n'

            print('Merging clips')
            merge_list_file = op.join(clips_dir, 'merge_list.txt')
            with open(merge_list_file, 'w') as fo:
                temp_str = '\n'.join(["file '{}'".format(tf) for tf in temp_files])
                fo.write(temp_str)

            cmd = ('ffmpeg -f concat -safe 0 -i {merge_list_file} -c copy '
                   '{run_file_nondrc}').format(
                        merge_list_file=merge_list_file, run_file_nondrc=run_file_nondrc)
            script += cmd + '\n\n'
        elif not op.isfile(run_file_nondrc):
            # split
            print('Splitting video')
            dur = split_times[1] - split_times[0]
            cmd = ('ffmpeg -ss {start_time} -i {episode_file} -t {duration} '
                   '{run_file_nondrc}').format(
                        start_time=split_times[0], duration=dur,
                        episode_file=mp4_file, run_file_nondrc=run_file_nondrc)
            script += cmd + '\n\n'
        else:
            print('Skipping run split. File already exists.')

        if not op.isfile(run_file_drc):
            print('\n\n\nPerforming dynamic range compression\n')
            cmd = ('ffmpeg -i {run_file_nondrc} -filter_complex '
                   '"[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0'
                   ':-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy '
                   '{run_file_drc}').format(
                        run_file_nondrc=run_file_nondrc, run_file_drc=run_file_drc)
            script += cmd + '\n\n'
        else:
            print('\n\n\nSkipping dynamic range compression. File already exists\n')

        if not op.isfile(run_file_final):
            print('\n\n\nDownsampling audio and video\n')
            cmd = ('ffmpeg -i {run_file_drc} -codec:v libx264 -crf 0 -preset '
                   'veryslow -ar 44100 {run_file_final}').format(
                        run_file_drc=run_file_drc, run_file_final=run_file_final)
            script += cmd

    with open('run_{}.sh'.format(fname), 'w') as fo:
        fo.write(script)


def get_parser():
    """
    Sets up argument parser
    """
    parser = argparse.ArgumentParser(description='Video splitter and converter')
    parser.add_argument('-i', '--inputfile', required=True, dest='episode_file',
                        help='File to split')
    parser.add_argument('-o', '--outputdir', required=True, dest='output_dir',
                        help='Output directory')
    return parser


def main(argv=None):
    """
    Function that executes when bidsify.py is called

    Parameters
    ----------
    episode_file
    output_dir
    """
    args = get_parser().parse_args(argv)
    build_script(args.episode_file, output_dir=args.output_dir)


if __name__ == '__main__':
    main()
