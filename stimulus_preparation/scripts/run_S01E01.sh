#Processing S01E01R01
#Splitting video
ffmpeg -ss 5.0 -i /scratch/tsalo006/stranger-things/raw/S01E01.mp4 -t 500.5 /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R01.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R01.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R01.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R01.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E01/S01E01R01.mp4

#Processing S01E01R02
#Splitting video
ffmpeg -ss 555.5 -i /scratch/tsalo006/stranger-things/raw/S01E01.mp4 -t 412.9 /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R02.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R02.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R02.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R02.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E01/S01E01R02.mp4

#Processing S01E01R03
#Splitting video
ffmpeg -ss 968.4 -i /scratch/tsalo006/stranger-things/raw/S01E01.mp4 -t 411.86 /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R03.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R03.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R03.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R03.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E01/S01E01R03.mp4

#Processing S01E01R04
#Splitting video
ffmpeg -ss 1380.26 -i /scratch/tsalo006/stranger-things/raw/S01E01.mp4 -t 428.5899999999999 /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R04.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R04.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R04.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R04.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E01/S01E01R04.mp4

#Processing S01E01R05
#Splitting video
ffmpeg -ss 1808.5 -i /scratch/tsalo006/stranger-things/raw/S01E01.mp4 -t 466.94000000000005 /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R05.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R05.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R05.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R05.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E01/S01E01R05.mp4

#Processing S01E01R06
#Splitting video
ffmpeg -ss 2275.44 -i /scratch/tsalo006/stranger-things/raw/S01E01.mp4 -t 498.65999999999985 /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R06.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/nondrc_S01E01R06.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R06.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E01/drc_S01E01R06.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E01/S01E01R06.mp4

