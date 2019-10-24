from glob import glob
import os.path as op
from moviepy.editor import VideoFileClip
import numpy as np

T_R = 1.5
START_FIX_DUR = T_R * 2
END_FIX_DUR = T_R * 3

in_dir = '/Users/tsalo/Desktop/diva-stimuli/'
subfolders = sorted(glob(op.join(in_dir, 'S*E*')))
subfolders = [s for s in subfolders if op.isdir(s)]
subfolders = [s for s in subfolders if not s.endswith('stats')]
for subfolder in subfolders:
    run_files = sorted(glob(op.join(in_dir, subfolder, 'S*E*R*.mp4')))
    ep_dur = 0
    for run_file in run_files:
        fname = op.splitext(op.basename(run_file))[0]
        dat = VideoFileClip(run_file)
        upper = np.ceil(dat.duration / T_R) * T_R
        diff = upper - dat.duration
        run_end_fix_dur = END_FIX_DUR + diff
        dur = START_FIX_DUR + dat.duration + run_end_fix_dur
        ep_dur += dur
        dur_str = '{0}:{1:05.02f}'.format(int(dur // 60), dur % 60)
        print('\t{0}: {1} ({2} TRs)'.format(fname, dur_str, (dur / T_R)))
    ep_dur_str = '{0}:{1:05.02f}'.format(int(ep_dur // 60), ep_dur % 60)
    print('{0}: {1}'.format(subfolder, ep_dur_str))
