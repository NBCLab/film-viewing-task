from glob import glob
import os.path as op
from moviepy.editor import VideoFileClip


START_FIX_DUR = 1.55 * 2
END_FIX_DUR = 1.55 * 3

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
        dur = START_FIX_DUR + dat.duration + END_FIX_DUR
        ep_dur += dur
        dur_str = '{0}:{1:05.02f}'.format(int(dur // 60), dur % 60)
        #print('\t{0}: {1}'.format(fname, dur_str))
    ep_dur_str = '{0}:{1:05.02f}'.format(int(ep_dur // 60), ep_dur % 60)
    print('{0}: {1}'.format(subfolder, ep_dur_str))
