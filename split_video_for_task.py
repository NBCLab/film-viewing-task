# coding: utf-8
import os
from os import mkdir
import os.path as op
from glob import glob
import subprocess
from shutil import copyfile

import numpy as np
import pandas as pd
from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip

SPLIT_TIMES = {'S01E01': [5., 505.5, 968., 1380.2, 1808.8, 2275.4, 2774.],
               'S01E02': [5.5, 524., 897.7, 1440.55, 1971.2, 2411.875, 2738.4, 3179.5],
               'S01E03': [5.5, 462.5, 927.21, 1402.52, 1940.8, 2342.1, 2966.],
               'S01E04': [5.5, 465.5, 958.2, 1397., 1896.6, 2240.9, 2886.],
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
    mp4_file = in_file.replace('.mov', '.mp4')
    srt_file = in_file.replace('.mov', '.srt')
    fname = op.splitext(op.basename(in_file))[0]
    out_dir = op.dirname(in_file)
    clips_dir = op.join(out_dir, fname)
    if not op.isdir(out_dir):
        mkdir(out_dir)

    split_times = SPLIT_TIMES[fname]

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

    # Split SRT file
    print('\n\n\nSplitting SRT file\n')
    cmd = ('srt split {times} {srt_file}').format(
        times=' '.join(['{}s'.format(t) for t in split_times]),
        srt_file=srt_file)
    print(cmd+'\n\n\n')
    run(cmd)

    srt_search_term = srt_file.replace('.srt', '.*.srt')
    srt_files = sorted(glob(srt_search_term))

    for i_run, start_time in enumerate(split_times[:-1]):
        run_file = op.join(clips_dir, 'c{0}R{1:02d}.mp4'.format(fname, i_run+1))
        run_file_drc = op.join(clips_dir, '{0}R{1:02d}.mp4'.format(fname, i_run+1))
        run_srt_file = op.join(clips_dir, '{0}R{1:02d}.srt'.format(fname, i_run+1))

        sel_srt_file = [f for f in srt_files if '.{}.srt'.format(i_run+2) in f][0]
        copyfile(sel_srt_file, run_srt_file)

        end_time = split_times[i_run+1]
        dur = end_time - start_time

        # split video
        if not op.isfile(run_file):
            print('\n\n\nSplitting scene {}\n'.format(i_run+1))
            ffmpeg_extract_subclip(mp4_file, start_time, end_time, targetname=run_file)
            cmd = ('ffmpeg -ss {start_time} -t {duration} -i {full_mp4} '
                   '{split_avi}').format(
                        start_time=start_time,
                        duration=dur,
                        full_mp4=mp4_file,
                        split_avi=run_file)
            print(cmd+'\n\n\n')
            # run(cmd)

        # crop and add black bars. Not doing this!
        # dynamic range compression
        if not op.isfile(run_file_drc):
            print('\n\n\nPerforming dynamic range compression\n\n\n')
            cmd = ('ffmpeg -i {split_avi} -filter_complex '
                   '"[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0'
                   ':-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy '
                   '{csplit_avi}').format(split_avi=run_file,
                                          csplit_avi=run_file_drc)
            run(cmd)

        # reencode video to Indeo 5.1 and audio to PCM uncompressed?
        # Not sure if necessary

    for run_srt_file in srt_files:
        os.remove(run_srt_file)


if __name__ == '__main__':
    in_dir = '/Users/tsalo/Desktop/diva-stimuli/'
    files = sorted(glob(op.join(in_dir, 'S01E0*.mov')))
    files = [s for s in files if op.isfile(s)]
    for in_file in files:
        fname = op.basename(in_file)
        if not op.isfile(in_file):
            print('File not found for {0}. Skipping.'.format(fname))
        else:
            print('Running {0}'.format(fname))
            split_video(in_file)
