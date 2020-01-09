#Processing S01E02R01
#Splitting video
ffmpeg -ss 5.5 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 269.5 /scratch/tsalo006/stranger-things/processed/S01E02/temp_S01E02R01_0.mp4

#Splitting video
ffmpeg -ss 325.0 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 199.04999999999995 /scratch/tsalo006/stranger-things/processed/S01E02/temp_S01E02R01_1.mp4

#Merging clips
ffmpeg -f concat -safe 0 -i /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R01_merge_list.txt -c copy /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R01.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R01.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R01.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R01.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R01.mp4

#Processing S01E02R02
#Splitting video
ffmpeg -ss 524.05 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 373.70000000000005 /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R02.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R02.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R02.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R02.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R02.mp4

#Processing S01E02R03
#Splitting video
ffmpeg -ss 897.75 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 542.8 /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R03.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R03.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R03.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R03.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R03.mp4

#Processing S01E02R04
#Splitting video
ffmpeg -ss 1440.55 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 530.7550000000001 /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R04.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R04.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R04.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R04.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R04.mp4

#Processing S01E02R05
#Splitting video
ffmpeg -ss 1971.305 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 440.98800000000006 /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R05.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R05.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R05.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R05.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R05.mp4

#Processing S01E02R06
#Splitting video
ffmpeg -ss 2412.293 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 326.13224999999966 /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R06.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R06.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R06.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R06.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R06.mp4

#Processing S01E02R07
#Splitting video
ffmpeg -ss 2738.42525 -i /scratch/tsalo006/stranger-things/raw/S01E02.mp4 -t 440.77475000000004 /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R07.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/nondrc_S01E02R07.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R07.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E02/drc_S01E02R07.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E02/S01E02R07.mp4

