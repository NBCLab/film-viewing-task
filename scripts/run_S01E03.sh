#Processing S01E03R01
#Splitting video
ffmpeg -ss 5.5 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 115.5 /scratch/tsalo006/stranger-things/processed/S01E03/temp_S01E03R01_0.mp4

#Splitting video
ffmpeg -ss 171.0 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 291.49 /scratch/tsalo006/stranger-things/processed/S01E03/temp_S01E03R01_1.mp4

#Merging clips
ffmpeg -f concat -safe 0 -i /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R01_merge_list.txt -c copy /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R01.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R01.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R01.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R01.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R01.mp4

#Processing S01E03R02
#Splitting video
ffmpeg -ss 462.49 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 464.99 /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R02.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R02.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R02.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R02.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R02.mp4

#Processing S01E03R03
#Splitting video
ffmpeg -ss 927.48 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 475.0274999999999 /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R03.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R03.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R03.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R03.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R03.mp4

#Processing S01E03R04
#Splitting video
ffmpeg -ss 1402.5075 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 538.3275000000001 /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R04.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R04.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R04.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R04.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R04.mp4

#Processing S01E03R05
#Splitting video
ffmpeg -ss 1940.835 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 401.33500000000004 /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R05.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R05.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R05.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R05.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R05.mp4

#Processing S01E03R06
#Splitting video
ffmpeg -ss 2342.17 -i /scratch/tsalo006/stranger-things/raw/S01E03.mp4 -t 623.8299999999999 /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R06.mp4

#Performing dynamic range compression
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/nondrc_S01E03R06.mp4 -filter_complex "[0:a]compand=.3|.3:1|1:-90/-60|-60/-40|-40/-30|-20/-20:6:0:-90:0.2[audio]" -map 0:v -map "[audio]" -codec:v copy /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R06.mp4

#Downsampling for PsychoPy compatibility
ffmpeg -i /scratch/tsalo006/stranger-things/processed/S01E03/drc_S01E03R06.mp4 -codec:v libx264 -crf 0 -preset veryslow -ar 44100 /scratch/tsalo006/stranger-things/processed/S01E03/S01E03R06.mp4

