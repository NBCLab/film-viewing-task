"""
Heavily adapted from https://github.com/courtois-neuromod/task_stimuli/blob/714cdbceb4991c9eab43a33e34aae0a2b148548d/src/tasks/video.py
Make sure to give credit to the authors.
"""
import os
import sys
import time

import pandas as pd

import psychopy
import psychopy.core  # pylint: disable=E0401
import psychopy.event  # pylint: disable=E0401
import psychopy.gui  # pylint: disable=E0401
import psychopy.visual  # pylint: disable=E0401
import psychopy.sound  # pylint: disable=E0401
from psychopy import visual, core, data, logging

END_DUR = 6


if __name__ == '__main__':
    # Collect user input
    # ------------------
    # Remember to turn fullscr to True for the real deal.

    exp_info = {'subject': '',
                'session': '',
                'run': ''}
    dlg = psychopy.gui.DlgFromDict(
        exp_info,
        title='Episode {0} Run {1}'.format(exp_info['session'], exp_info['run']),
        order=['subject', 'session'])
    window = psychopy.visual.Window(
        size=(800, 600), fullscr=True, monitor='testMonitor', units='deg',
        allowStencil=False, allowGUI=False)
    if not dlg.OK:
        psychopy.core.quit()

    filename = ('data/sub-{0}_ses-{1}_task-StrangerThings'
                '_run-{2}_events').format(
                    exp_info['subject'].zfill(2),
                    exp_info['session'].zfill(2),
                    exp_info['run'].zfill(2))

    config_file = 'stranger_things_config.tsv'
    config_df = pd.read_csv(config_file, sep='\t')
    file_ = config_df.loc[(config_df['session'] == int(exp_info['session'])) &
                          (config_df['run'] == int(exp_info['run'])), 'file'].values[0]
    video = psychopy.visual.MovieStim(window, filename=file_)

    # Waiting for scanner
    waiting = psychopy.visual.TextStim(
        window,
        """You are about to watch a video.
Please keep your eyes open.""")

    # Rest between tasks
    crosshair = psychopy.visual.TextStim(window, '+', height=2)

    # Scanner runtime
    # ---------------
    # Wait for trigger from scanner.
    waiting.draw()
    window.flip()
    psychopy.event.waitKeys(keyList=['space', '5'])

    startTime = datetime.now()
    routine_clock = psychopy.core.Clock()

    video.draw()
    fixStartTime = routine_clock.getTime()
    duration = fixStartTime - startTime

    # End with six seconds of rest
    draw(win=window, stim=crosshair, duration=END_DUR)

    # Compile file
    COLUMNS = ['onset', 'duration', 'stim_file']
    data = [[startTime, duration, file_],
            [fixStartTime, fixDuration, 'n/a']]
    out_frame = pd.DataFrame(columns=COLUMNS, data=data)
    out_frame.to_csv(filename + '.tsv', sep='\t', na_rep='n/a', index=False)

    end_screen = psychopy.visual.TextStim(window, "The task is now complete!")
    end_screen.draw()
    window.flip()
    psychopy.event.waitKeys(keyList=['space', '5', 'escape'])
