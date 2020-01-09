#Processing S01E06R01
#Splitting video
ffmpeg -ss 5.5 -i /scratch/tsalo006/stranger-things/raw/S01E06.mp4 -t 142.5 /scratch/tsalo006/stranger-things/processed/S01E06/temp_S01E06R01_0.mp4

#Splitting video
ffmpeg -ss 198.0 -i /scratch/tsalo006/stranger-things/raw/S01E06.mp4 -t 329.79999999999995 /scratch/tsalo006/stranger-things/processed/S01E06/temp_S01E06R01_1.mp4

#Merging clips
ffmpeg -f concat -safe 0 -i /scratch/tsalo006/stranger-things/processed/S01E06/S01E06R01_merge_list.txt -c copy /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R01.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R01.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R01.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R01.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E06/S01E06R01.mp4

#Processing S01E06R02
#Splitting video
ffmpeg -ss 527.801 -i /scratch/tsalo006/stranger-things/raw/S01E06.mp4 -t 437.664 /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R02.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R02.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R02.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R02.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E06/S01E06R02.mp4

#Processing S01E06R03
#Splitting video
ffmpeg -ss 965.466 -i /scratch/tsalo006/stranger-things/raw/S01E06.mp4 -t 425.6139999999999 /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R03.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R03.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R03.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R03.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E06/S01E06R03.mp4

#Processing S01E06R04
#Splitting video
ffmpeg -ss 1391.081 -i /scratch/tsalo006/stranger-things/raw/S01E06.mp4 -t 612.144 /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R04.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R04.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R04.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R04.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E06/S01E06R04.mp4

#Processing S01E06R05
#Splitting video
ffmpeg -ss 2003.226 -i /scratch/tsalo006/stranger-things/raw/S01E06.mp4 -t 658.7739999999999 /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R05.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/nondrc_S01E06R05.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R05.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E06/drc_S01E06R05.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E06/S01E06R05.mp4

