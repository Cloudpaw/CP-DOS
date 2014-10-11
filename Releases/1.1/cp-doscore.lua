
local function dofile (filename) -- we need this later.
          local f = assert(loadfile(filename))
          return f()
        end
local function get(paste) -- This function is from pastebin program.
        local response = http.get(
                "http://pastebin.com/raw.php?i=0UnwMYY4"..textutils.urlEncode( paste )
        )
          
        if response then
                --print( "Success." )
          
                local sResponse = response.readAll()
                response.close()
                return sResponse
        else
                print( "Update failed." )
        end
end
local version = "1.1" -- Put the version in here.
local pastetoget = "0UnwMYY4" -- Enter your paste
local dataweneed = get(pastetoget)
if string.find( dataweneed, 'local version = "'..version..'"' ) then -- This if part can be commented out if you want to disable UPDATES on your own computer.
-- if you are coding it in-game etc.




-- If this happens, our program found a different version on pastebin
local handsofthedead = fs.open(".updatedprog","w")
handsofthedead.write(dataweneed)
handsofthedead.close()
fs.move(shell.getRunningProgram(),"noneedanymore")
fs.move(".updatedprog",shell.getRunningProgram() )
fs.delete("noneedanymore")
-- Process ends after here. Update done. TADAA.
-- We should add some kind of thing so user knows wtf happened
print("The program updated.")
dofile(shell.getRunningProgram())
return
end

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
os.pullEvent = os.pullEventRaw

--SHA256
local MOD = 2^32
local MODM = MOD-1
 
local function memoize(f)
        local mt = {}
        local t = setmetatable({}, mt)
        function mt:__index(k)
                local v = f(k)
                t[k] = v
                return v
        end
        return t
end
 
local function make_bitop_uncached(t, m)
        local function bitop(a, b)
                local res,p = 0,1
                while a ~= 0 and b ~= 0 do
                        local am, bm = a % m, b % m
                        res = res + t[am][bm] * p
                        a = (a - am) / m
                        b = (b - bm) / m
                        p = p*m
                end
                res = res + (a + b) * p
                return res
        end
        return bitop
end
 
local function make_bitop(t)
        local op1 = make_bitop_uncached(t,2^1)
        local op2 = memoize(function(a) return memoize(function(b) return op1(a, b) end) end)
        return make_bitop_uncached(op2, 2 ^ (t.n or 1))
end
 
local bxor1 = make_bitop({[0] = {[0] = 0,[1] = 1}, [1] = {[0] = 1, [1] = 0}, n = 4})
 
local function bxor(a, b, c, ...)
        local z = nil
        if b then
                a = a % MOD
                b = b % MOD
                z = bxor1(a, b)
                if c then z = bxor(z, c, ...) end
                return z
        elseif a then return a % MOD
        else return 0 end
end
 
local function band(a, b, c, ...)
        local z
        if b then
                a = a % MOD
                b = b % MOD
                z = ((a + b) - bxor1(a,b)) / 2
                if c then z = bit32_band(z, c, ...) end
                return z
        elseif a then return a % MOD
        else return MODM end
end
 
local function bnot(x) return (-1 - x) % MOD end
 
local function rshift1(a, disp)
        if disp < 0 then return lshift(a,-disp) end
        return math.floor(a % 2 ^ 32 / 2 ^ disp)
end
 
local function rshift(x, disp)
        if disp > 31 or disp < -31 then return 0 end
        return rshift1(x % MOD, disp)
end
 
local function lshift(a, disp)
        if disp < 0 then return rshift(a,-disp) end
        return (a * 2 ^ disp) % 2 ^ 32
end
 
local function rrotate(x, disp)
    x = x % MOD
    disp = disp % 32
    local low = band(x, 2 ^ disp - 1)
    return rshift(x, disp) + lshift(low, 32 - disp)
end
 
local k = {
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
        0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
        0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
        0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
        0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
        0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
        0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
        0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
        0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
}
 
local function str2hexa(s)
        return (string.gsub(s, ".", function(c) return string.format("%02x", string.byte(c)) end))
end
 
local function num2s(l, n)
        local s = ""
        for i = 1, n do
                local rem = l % 256
                s = string.char(rem) .. s
                l = (l - rem) / 256
        end
        return s
end
 
local function s232num(s, i)
        local n = 0
        for i = i, i + 3 do n = n*256 + string.byte(s, i) end
        return n
end
 
local function preproc(msg, len)
        local extra = 64 - ((len + 9) % 64)
        len = num2s(8 * len, 8)
        msg = msg .. "\128" .. string.rep("\0", extra) .. len
        assert(#msg % 64 == 0)
        return msg
end
 
local function initH256(H)
        H[1] = 0x6a09e667
        H[2] = 0xbb67ae85
        H[3] = 0x3c6ef372
        H[4] = 0xa54ff53a
        H[5] = 0x510e527f
        H[6] = 0x9b05688c
        H[7] = 0x1f83d9ab
        H[8] = 0x5be0cd19
        return H
end
 
local function digestblock(msg, i, H)
        local w = {}
        for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end
        for j = 17, 64 do
                local v = w[j - 15]
                local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))
                v = w[j - 2]
                w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))
        end
 
        local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
        for i = 1, 64 do
                local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
                local maj = bxor(band(a, b), band(a, c), band(b, c))
                local t2 = s0 + maj
                local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
                local ch = bxor (band(e, f), band(bnot(e), g))
                local t1 = h + s1 + ch + k[i] + w[i]
                h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2
        end
 
        H[1] = band(H[1] + a)
        H[2] = band(H[2] + b)
        H[3] = band(H[3] + c)
        H[4] = band(H[4] + d)
        H[5] = band(H[5] + e)
        H[6] = band(H[6] + f)
        H[7] = band(H[7] + g)
        H[8] = band(H[8] + h)
end
 
function sha256(msg)
        msg = preproc(msg, string.len(msg))
        local H = initH256({})
        for i = 1, #msg, 64 do digestblock(msg, i, H) end
        return str2hexa(num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) ..
                num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))
end

--END SHA256

if fs.exists("/startup") and not fs.exists("/startup.bak") then
  fs.move("/startup", "/startup.bak")
elseif fs.exists("/startup") and fs.exists("/startup.bak") then
  fs.delete("startup.bak")
  fs.move("startup", "startup.bak")
end

fs.makeDir(".sertexsecurity")

local bg, text, pass, inputpw, wrong
if term.isColour() then
  bg = colors.white
  text = colors.red
  pass = colors.blue
  inputpw = colors.green
  wrong = colors.red
else
  bg = colors.black
  text = colors.white
  pass = colors.white
  inputpw = colors.white
  wrong = colors.white
end

while true do
term.setBackgroundColor( bg )
term.clear()
term.setCursorPos(1,1)
term.setTextColor( text )
print("SertexSecurity SETUP")
term.setTextColor( pass )
write("Insert Password: ")
term.setTextColor( inputpw )
local pw1 = read("*")
term.setTextColor( pass )
write("Repeat: ")
term.setTextColor( inputpw )
local pw2 = read("*")

if pw1 == pw2 then
  local file = fs.open(".sertexsecurity/.password", "w")
  local crypt = sha256(pw2)
  file.write(crypt)
  break
else
  printError("Wrong password")
  sleep(2)
end
end
sleep(2)
term.clear()
term.setCursorPos(1,1)
term.setTextColor( text )
textutils.slowPrint("Rebooting...")
sleep(1)
os.reboot()
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
