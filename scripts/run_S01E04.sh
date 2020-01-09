#Processing S01E04R01
#Splitting video
ffmpeg -ss 5.5 -i /scratch/tsalo006/stranger-things/raw/S01E04.mp4 -t 460.0 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R01.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R01.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R01.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R01.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/S01E04R01.mp4

#Processing S01E04R02
#Splitting video
ffmpeg -ss 515.5 -i /scratch/tsalo006/stranger-things/raw/S01E04.mp4 -t 442.70000000000005 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R02.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R02.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R02.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R02.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/S01E04R02.mp4

#Processing S01E04R03
#Splitting video
ffmpeg -ss 958.2 -i /scratch/tsalo006/stranger-things/raw/S01E04.mp4 -t 439.1199999999999 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R03.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R03.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R03.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R03.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/S01E04R03.mp4

#Processing S01E04R04
#Splitting video
ffmpeg -ss 1397.32 -i /scratch/tsalo006/stranger-things/raw/S01E04.mp4 -t 499.48 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R04.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R04.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R04.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R04.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/S01E04R04.mp4

#Processing S01E04R05
#Splitting video
ffmpeg -ss 1896.8 -i /scratch/tsalo006/stranger-things/raw/S01E04.mp4 -t 344.10000000000014 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R05.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R05.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R05.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R05.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/S01E04R05.mp4

#Processing S01E04R06
#Splitting video
ffmpeg -ss 2240.9 -i /scratch/tsalo006/stranger-things/raw/S01E04.mp4 -t 645.0999999999999 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R06.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/nondrc_S01E04R06.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R06.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/drc_S01E04R06.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E04/S01E04/S01E04R06.mp4

