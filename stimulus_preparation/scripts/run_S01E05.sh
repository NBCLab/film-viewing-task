#Processing S01E05R01
#Splitting video
ffmpeg -ss 5.5 -i /scratch/tsalo006/stranger-things/raw/S01E05.mp4 -t 489.5 /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R01.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R01.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R01.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R01.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E05/S01E05R01.mp4

#Processing S01E05R02
#Splitting video
ffmpeg -ss 545.5 -i /scratch/tsalo006/stranger-things/raw/S01E05.mp4 -t 440.77700000000004 /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R02.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R02.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R02.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R02.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E05/S01E05R02.mp4

#Processing S01E05R03
#Splitting video
ffmpeg -ss 986.277 -i /scratch/tsalo006/stranger-things/raw/S01E05.mp4 -t 523.1479999999999 /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R03.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R03.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R03.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R03.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E05/S01E05R03.mp4

#Processing S01E05R04
#Splitting video
ffmpeg -ss 1509.425 -i /scratch/tsalo006/stranger-things/raw/S01E05.mp4 -t 441.10699999999997 /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R04.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R04.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R04.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R04.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E05/S01E05R04.mp4

#Processing S01E05R05
#Splitting video
ffmpeg -ss 1950.532 -i /scratch/tsalo006/stranger-things/raw/S01E05.mp4 -t 512.0530000000001 /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R05.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R05.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R05.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R05.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E05/S01E05R05.mp4

#Processing S01E05R06
#Splitting video
ffmpeg -ss 2462.585 -i /scratch/tsalo006/stranger-things/raw/S01E05.mp4 -t 575.915 /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R06.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/nondrc_S01E05R06.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R06.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E05/drc_S01E05R06.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E05/S01E05R06.mp4

