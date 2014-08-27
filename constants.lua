local rtn={}

rtn.currentLevel = 0
rtn.levelSize={}
rtn.level0RoomCount = 4
rtn.levelSize = {}
rtn.levelSize[1] = {0, 0, 550, 445}
rtn.level0RoomX={50, 50, 200, 425}
rtn.level0RoomY={50, 95, 50, 270}
rtn.level0RoomW={50, 100, 300, 75}
rtn.level0RoomH={25, 300, 200, 50}
rtn.level0CivX={60, 80, 100}
rtn.level0CivY={60, 60, 60}
rtn.level0Zombies = 5
rtn.scrollSpeed = nil
rtn.levelCleared = {}
rtn.infUnlocked = 0

rtn.saveFile = system.pathForFile( "zenbiesave.txt", system.DocumentsDirectory)

return rtn