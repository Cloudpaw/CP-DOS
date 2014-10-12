
local function getFreeMem()
  local bytesFree = fs.getFreeSpace("/")
  local kbFree = math.ceil(bytesFree / 1024)
  local mbFree = math.ceil(kbFree / 1024)
 
  if fs.exists("/disk") then
        diskFree = fs.getFreeSpace("/disk")
        diskKB = math.ceil(diskFree / 1024)
        diskMB = math.ceil(diskKB / 1024)
        diskPresent = true
  end
 
sleep(0.5)
  print("Approx. Bytes free: "..bytesFree)
sleep(0.5)
  print("Approx. KB free: "..kbFree)
sleep(0.5)
  print("Approx. MB free: "..mbFree)
sleep(0.5)
 if diskPresent then
        print("|DISK|")
sleep(0.5)
        print("Approx. Bytes free: "..diskFree)
sleep(0.5)
        print("Approx. KB free: "..diskKB)
sleep(0.5)
        print("Approx. MB free: "..diskMB)
  end
end
 
 
 
 
local function Boot()
term.clear()
textutils.slowPrint("Booting CP-DOS")
sleep(2)
print("Booted!")
sleep(0.3)
term.clear()
sleep(0.5)
print("CP-DOS 1.1")
sleep(0.5)
getFreeMem()
sleep(0.5)
textutils.slowPrint("Terminal mode is active!")
sleep(0.5)
print("THIS OS IN ALPHA IT STILL USES CRAFTOS FOR IT'S BASE!")
sleep(0.5)
print("THIS WILL CHANGE!")
sleep(0.5)
print("More programs will be inclued soon!")
sleep(0.5)
print("Type advow for all the names of the creators from the apps")
sleep(0.5)
print("Type in advpro for an Advanced Program List")
sleep(0.5)
end
Boot()
