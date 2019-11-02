# coding: utf-8
"""
Scene detection:
scenedetect --input ../S01E05.mp4 --stats S01E05_stats.csv detect-content --threshold 27 list-scenes
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
                          (545.5, 986.277),
                          (986.277, 1509.425),
                          (1509.425, 1950.532),
                          (1950.532, 2462.585),
                          (2462.585, 3038.5)],
               'S01E06': [((5.5, 148.), (198., 527.8)),
                          (527.801, 965.465),
                          (965.466, 1391.08),
                          (1391.081, 2003.225),
                          (2003.226, 2662.)],
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


def split_video(episode_file, output_dir=None):
    mp4_file = episode_file.replace('.mp4', '.mp4')
    fname = op.splitext(op.basename(episode_file))[0]
    if output_dir is None:
        out_dir = op.dirname(episode_file)
    else:
        out_dir = output_dir
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
        cmd = ('ffmpeg -i {episode_file} -q:v 1 -vcodec mpeg4 '
               '{mp4_file}').format(
                    episode_file=episode_file,
                    mp4_file=mp4_file)
        print(cmd+'\n\n\n')
        run(cmd)

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
                            start_time=clip_split_times[0],
                            duration=dur,
                            video_file=mp4_file,
                            clip_file=temp_files[j_clip])
                print(cmd+'\n\n\n')
                run(cmd)

            print('Merging clips')
            merge_list_file = op.join(clips_dir, 'merge_list.txt')
            with open(merge_list_file, 'w') as fo:
                temp_str = '\n'.join(["file '{}'".format(tf) for tf in temp_files])
                fo.write(temp_str)

            cmd = ('ffmpeg -f concat -safe 0 '
                   '-i {merge_list_file} -c copy '
                   '{run_file_nondrc}').format(
                        merge_list_file=merge_list_file,
                        run_file_nondrc=run_file_nondrc)
            print(cmd+'\n\n\n')
            run(cmd)

            print('Removing temporary files')
            os.remove(merge_list_file)
            for tf in temp_files:
                os.remove(tf)
        elif not op.isfile(run_file_nondrc):
            # split
            print('Splitting video')
            dur = split_times[1] - split_times[0]
            cmd = ('ffmpeg -ss {start_time} -i {episode_file} -t {duration} '
                   '{run_file_nondrc}').format(
                        start_time=split_times[0],
                        duration=dur,
                        episode_file=mp4_file,
                        run_file_nondrc=run_file_nondrc)
            print(cmd+'\n\n\n')
            run(cmd)
        else:
            print('Skipping run split. File already exists.')

        if not op.isfile(run_file_drc):
            print('\n\n\nPerforming dynamic range compression\n')
            cmd = ('ffmpeg -i {run_file_nondrc} -filter_complex '
                   '"[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0'
                   ':-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy '
                   '{run_file_drc}').format(
                        run_file_nondrc=run_file_nondrc,
                        run_file_drc=run_file_drc)
            print(cmd+'\n\n\n')
            run(cmd)
        else:
            print('\n\n\nSkipping dynamic range compression. File already exists\n')

        if not op.isfile(run_file_final):
            print('\n\n\nDownsampling audio and video\n')
            cmd = ('ffmpeg -i {run_file_drc} -codec:v libx264 '
                   '-crf 0 -preset veryslow -ar 44100 '
                   '{run_file_final}').format(
                        run_file_drc=run_file_drc,
                        run_file_final=run_file_final)
            print(cmd+'\n\n\n')
            run(cmd)


def get_parser():
    '''
    Sets up argument parser
    '''
    parser = argparse.ArgumentParser(description='Video splitter and converter')
    parser.add_argument('-i', '--inputfile', required=True, dest='episode_file',
                        help='File to split')
    parser.add_argument('-o', '--outputdir', required=True, dest='output_dir',
                        help='Output directory')
    return parser


def main(argv=None):
    '''
    Function that executes when bidsify.py is called
    Parameters inherited from argparser
    ----------
    dicom_dir: Directory cointaining dicom data to be processed
    heuristics: Path to heuristics file
    sub: Subject ID
    ses: Session ID, if required
    output_dir: Directory to output bidsified data
    '''
    args = get_parser().parse_args(argv)
    split_video(args.episode_file, output_dir=args.output_dir)


if __name__ == '__main__':
    main()
