"""
Heavily adapted from https://github.com/courtois-neuromod/task_stimuli/blob/714cdbceb4991c9eab43a33e34aae0a2b148548d/src/tasks/video.py
Make sure to give credit to the authors.
"""
import os
import sys
import time
from datetime import datetime
import pandas as pd
import numpy as np

import psychopy
import psychopy.core  # pylint: disable=E0401
import psychopy.event  # pylint: disable=E0401
import psychopy.gui  # pylint: disable=E0401
import psychopy.visual  # pylint: disable=E0401
import psychopy.sound  # pylint: disable=E0401
from psychopy import visual, core, data, logging
from psychopy.constants import STARTED, STOPPED  # pylint: disable=E0401

START_FIX_DUR = 2
END_FIX_DUR = 6


def close_on_esc(win):
    """
    Closes window if escape is pressed
    """
    if 'escape' in psychopy.event.getKeys():
        win.close()
        psychopy.core.quit()


def draw(win, stim, duration):
    """
    Draw stimulus for a given duration.

    Parameters
    ----------
    win : (psychopy.visual.Window)
    stim : object with `.draw()` method
    duration : (numeric) duration in seconds to display the stimulus
    """
    # Use a busy loop instead of sleeping so we can exit early if need be.
    start_time = time.time()
    response = psychopy.event.BuilderKeyResponse()
    response.tStart = start_time
    response.frameNStart = 0
    response.status = STARTED
    window.callOnFlip(response.clock.reset)
    psychopy.event.clearEvents(eventType='keyboard')
    while time.time() - start_time < duration:
        stim.draw()
        keys = psychopy.event.getKeys(keyList=['1', '2'],
                                      timeStamped=trials_clock)
        if keys:
            response.keys.extend(keys)
            response.rt.append(response.clock.getTime())
        close_on_esc(win)
        win.flip()
    response.status = STOPPED
    return response.keys, response.rt


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

    end_screen = psychopy.visual.TextStim(window, "The task is now complete!")

    # Rest between tasks
    crosshair = psychopy.visual.TextStim(window, '+', height=2)

    if not os.path.exists('data'):
        os.makedirs('data')

    # Scanner runtime
    # ---------------
    # Wait for trigger from scanner.
    waiting.draw()
    window.flip()
    psychopy.event.waitKeys(keyList=['space', '5'])
    trials_clock = psychopy.core.Clock()
    routine_clock = psychopy.core.Clock()

    # Start with fixation
    startTimeFix1 = routine_clock.getTime()
    draw(win=window, stim=crosshair, duration=START_FIX_DUR)

    # Now the video
    startTimeVid = routine_clock.getTime()
    durationFix1 = startTimeVid - startTimeFix1

    video.autoDraw = False

    fps = 1 / window.monitorFramePeriod
    n_frames = int(np.ceil(video.duration * fps))
    # n_frames = int(np.ceil(10 * fps))  # test with 10 seconds
    for t in range(n_frames):
        video.draw(window)
        window.flip()
        close_on_esc(window)

    startTimeFix2 = routine_clock.getTime()
    durationVid = startTimeFix2 - startTimeVid

    # End with fixation
    draw(win=window, stim=crosshair, duration=END_FIX_DUR)

    startTimeEnd = routine_clock.getTime()
    durationFix2 = startTimeEnd - startTimeFix2

    # Final note that task is over. Runs after scan ends.
    draw(win=window, stim=end_screen, duration=2)
    window.flip()

    # Calculate time and duration just in case we want them in the future
    endTime = routine_clock.getTime()
    durationEnd = endTime - startTimeEnd

    # Compile file
    COLUMNS = ['onset', 'duration', 'trial_type', 'stim_file']
    data = [[startTimeFix1, durationFix1, 'fixation', 'n/a'],
            [startTimeVid, durationVid, 'film', file_],
            [startTimeFix2, durationFix2, 'fixation', 'n/a']]

    out_frame = pd.DataFrame(columns=COLUMNS, data=data)
    out_frame.to_csv(filename + '.tsv', sep='\t', na_rep='n/a', index=False)
