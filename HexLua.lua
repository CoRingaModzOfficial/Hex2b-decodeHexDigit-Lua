--*CoRinga Modz Developer *--
local CMODs = {}
local JAVA_HEAP = 2
local C_HEAP = 1
local C_ALLOC = 4
local C_DATA = 8
local C_BSS = 10
local A_ANONYMOUS = 32
local JAVA = 65536
local STACK = 64
local ASHMEM = 524288
local V_VIDEO = 1048576
local B_BAD = 131072
local CODE_APP = 16384
local CODE_SYSTEM = 32768
local BYTE = 1
local WORD = 2
local DWORD = 4
local XOR = 8
local FLOAT = 16
local QWORD = 32
local DOUBLE = 64
local AUTO = 127
local memFrom, memTo, lib, num, lim, results, src, ok = 0, -1, nil, 0, 32, {}, nil, false
function NameLIB_CMODs(n)
if lib ~= n then lib = n
local ranges = gg.getRangesList(lib)
if #ranges == 0 then
print("Error "..lib.."Game Lib not Encountered")
gg.toast("Error : "..lib.."Game Lib not Encountered")
os.exit()
else memFrom = ranges[1].start memTo = ranges[#ranges]["end"]end end
end
function hex2tbl(hex)
local ret = {} hex:gsub("%S%S",
function (ch) ret[#ret + 1] = ch return ""end)return ret
end
function Write_CMODs(repl)
num = num + 1
local tbl = hex2tbl(repl)
if src ~= nil then
local source = hex2tbl(src) for i, v in ipairs(tbl) do
if v ~= "??" and v ~= "**" and v == source[i] then tbl[i] = "**" end end src = nil end
local cnt = #tbl
local set = {}
local s = 0 for _, addr in ipairs(results) do for i, v in ipairs(tbl) do
if v ~= "??" and v ~= "**" then s = s + 1 set[s] = {["address"] = addr + i,["value"] = v.."r",["flags"] = gg.TYPE_BYTE,}end end end
if s ~= 0 then
gg.setValues(set) end
ok = true
end
function CMODs.memoryUtils(succesMessage, notSuccessMessage, memoryRanges, memorySearch, memoryWrite, clearResults)
    gg.clearResults()
    gg.setVisible(false)
    gg.setRanges(memoryRanges)
    local valueType = memorySearch[1][3]
    local valueTypeModify = memoryWrite[1][3]
    gg.searchNumber(memorySearch[1][1], valueType)
    local valueCount = gg.getResultCount()
    local valueResult = gg.getResults(valueCount)
    gg.clearResults()
    local valueData = {} 
    local valueBase = memorySearch[1][2]
    if (valueCount > 0) then
        for i, v in ipairs(valueResult) do
            v.isUseful = true 
        end
function HexOriginal_CMODs(orig)
local tbl = hex2tbl(orig)
local len = #tbl
if len == 0 then return end
local used = len
if len > lim then used = lim end
local s = '' for i = 1, used do
if i ~= 1 then s = s..";" end
local v = tbl[i]
if v == "??" or v == "**" then v = "0~~0" end s = s..v.."r"end s = s.."::"..used
gg.searchNumber(s, gg.TYPE_BYTE, false, gg.SIGN_EQUAL, memFrom, memTo)
if len > used then for i = used + 1, len do
local v = tbl[i]
if v == "??" or v == "**" then v = 256 else v = ("0x"..v) + 0
if v > 127 then v = v - 256 end end tbl[i] = v end end
local found = gg.getResultCount(); results = {}
local count = 0
local checked = 0
while true do
if checked >= found then break end
local all = gg.getResults(8)
local total = #all
local start = checked
if checked + used > total then break end for i, v in ipairs(all) do v.address = v.address + Offset_CMODs end
gg.loadResults(all)while start < total do  
local good = true
local offset = all[1 + start].address - 1
if used < len then   
local get = {} for i = lim + 1, len do get[i - lim] = {address = offset + i, flags = gg.TYPE_BYTE, value = 0}end
get = gg.getValues(get) for i = lim + 1, len do
local ch = tbl[i]
if ch ~= 256 and get[i - lim].value ~= ch then good = false break end end end
if good then count = count + 1 results[count] = offset checked = checked + used else
local del = {} for i = 1, used do del[i] = all[i + start]end
gg.removeResults(del)end start = start + used end end
end
        for k=2, #memorySearch do
            local valueTmp = {}
            local valueOffset = memorySearch[k][2] - valueBase 
            local valueNum = memorySearch[k][1] 
            for i, v in ipairs(valueResult) do
                valueTmp[#valueTmp+1] = {} 
                valueTmp[#valueTmp].address = v.address + valueOffset
                valueTmp[#valueTmp].flags = v.flags  
            end       
            valueTmp = gg.getValues(valueTmp)  
            for i, v in ipairs(valueTmp) do
                if ( tostring(v.value) ~= tostring(valueNum) ) then 
                    valueResult[i].isUseful = false 
                end
            end
        end
        for i, v in ipairs(valueResult) do
            if (v.isUseful) then 
                valueData[#valueData+1] = v.address
            end
        end
        if (#valueData > 0) then    
           local t = {}
           local valueBase = memorySearch[1][2]
           for i=1, #valueData do
               for k, w in ipairs(memoryWrite) do
                   valueOffset = w[2] - valueBase
                   t[#t+1] = {}
                   t[#t].address = valueData[i] + valueOffset
                   t[#t].flags = valueTypeModify
                   t[#t].value = w[1]           
                   if (w[4] == true) then
                       local valueItem = {}
                       valueItem[#valueItem+1] = t[#t]
                       valueItem[#valueItem].freeze = true
                       gg.addListItems(valueItem)
                   end         
               end
           end
           gg.setValues(t)
           gg.clearResults()
           if (succesMessage == nil ) then
           else
           Toast(succesMessage)
           end
        else
            if (notSuccessMessage == nil ) then
            else
            Toast(notSuccessMessage, false)
            end
            return false
        end
    else
            if (notSuccessMessage == nil ) then
            else
            Toast(notSuccessMessage)
            end
        return false
    end
end
function Toast(msg)
gg.toast(tostring(msg))
end
function Alert(msg)
gg.alert(tostring(msg))
end
function CMODs.setMemoryRanges(ranges)
return ranges
end
function CMODs.memorySearch(valueSearch)
return valueSearch
end
function CMODs.memoryWrite(valueWrite)
return valueWrite
end
function CMODs.clearResults()
gg.clearResults()
end
function succesMessage(msg)
return msg
end
function notSuccessMessage(msg)
return msg
end

----GameVar()
local aimbot = false
local headshot = false
---end testing






-----©©GUIA
--*******Credits By : CoRinga Modz Telegram @CoRingaModYT 
--HEX OFFSET LUA CODE
--OFFSET (Offset_CMODs)
--NAME LIBRARY INJ (NameLIB_CMODs)
--WRITE HEX (Write_CMODs)
--ORIGINAL HEX FOR RESTORE HEX (HexOriginal_CMODs)
--*******--





