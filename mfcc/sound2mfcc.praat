dir$ = "../../data/data/Barn_Swallow/"

# FIND ALL MP3 FILES IN THE DIRECTORY
Create Strings as file list: "fileList", dir$ + "*.mp3"
numberOfFiles = Get number of strings

# LOOP THROUGH ALL THE MP3 FILES
for fileNumber to numberOfFiles
	#OPEN THEM
	select Strings fileList
	fileName$ = Get string: fileNumber
	baseFile$ = fileName$ - ".mp3"
	Read from file: dir$ + "/" + fileName$

	#CONVERT THEM TO MFCC AND SAVE THEM
	select Sound 'baseFile$'
	To MFCC: 12, 0.015, 0.005, 100, 100, 0
	To Matrix
	Write to matrix text file: dir$ + "/" + baseFile$ + ".txt"

	#CLEAN UP
	select MFCC 'baseFile$'
	plus Matrix 'baseFile$'
	plus Sound 'baseFile$'
	Remove
endfor

select Strings fileList
Remove