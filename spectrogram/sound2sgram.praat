# exec: praat --run spectrogram.praat "inDir$" "outDir$" "mp3Num$"

form Input and Output
	sentence InDir ../../data/data/Barn_Swallow/
	sentence OutDir ../2/
	sentence Mp3Num 3
endform

filename$  = inDir$ + mp3Num$ + ".mp3"
windowSize = 0.025
fRange     = 12000
timeStep   = 0.010

# select a MP3 file to generate, label, and save 300 dpi spectrogram images.
sound = Read from file: filename$

# set 12000 Hz as the upper bound for a publishable spectrogram
# argv: window size, view range, timestep, dynamic range, window shape
sgram = To Spectrogram: windowSize, fRange, timeStep, 20, "Gaussian"

numberOfFrames = Get number of frames

x0 = windowSize * 10
y0 = fRange / 10000

for frameNumber from 1 to numberOfFrames
	startTime = Get time from frame number: frameNumber
	endTime = startTime + windowSize
    
	# paint the spectrogram in every windows
	Erase all
	Select inner viewport: 0, x0, 0, y0
	Axes: 0, x0, 0, y0
	# argv: time range, frequency range, maximun, autoscaling, dynamic range, ... , garnish
	Paint: startTime, endTime, 0, 0, 100, "yes", 50, 6, 0, "no"
	Select outer viewport: 0, x0, 0, y0
	Save as 300-dpi PNG file: outDir$ + mp3Num$ + "_" + string$( frameNumber ) + ".png"
endfor

removeObject( sgram )
removeObject( sound )