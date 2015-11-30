form Directory Path
	sentence Dir ../../data/data/Barn_Swallow/
endform

# FIND ALL MP3 FILES IN THE DIRECTORY
listName$ = "fileList"
Create Strings as file list: listName$, dir$ + "*.mp3"
numberOfFiles = Get number of strings

# LOOP THROUGH ALL THE MP3 FILES
for fileNumber to numberOfFiles
	#OPEN THEM
	selectObject: "Strings " + listName$
	fileName$ = Get string: fileNumber
	baseFile$ = fileName$ - ".mp3"
	Read from file: dir$ + "/" + fileName$

	#CONVERT THEM TO MFCC AND SAVE THEM
	select Sound 'baseFile$'
	To MFCC: 12, 0.015, 0.005, 100, 100, 0
	To Matrix
	Write to matrix text file: dir$ + "/" + baseFile$ + ".txt"

	#CLEAN UP
	selectObject: "MFCC " + baseFile$
	plusObject: "Matrix " + baseFile$
	plusObject: "Sound " + baseFile$
	Remove
endfor

selectObject: "Strings " + listName$
Remove