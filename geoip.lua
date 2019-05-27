local geoip = {}
local db = {}
local gsub = string.gsub
local gmatch = string.gmatch
local mid = nil

local function dec_ip(ip)
   local dec,i,j = 0,0,4
   for s in gmatch(ip,"[0-9]+") do
      i = i+1
      j = j-1
      if j < 0 then return nil, "Invalid IP address." end
      dec = dec + tonumber(s) * 256^j
   end
   if i ~= 4 then return nil, "Invalid IP address." end
   return dec, nil
end

function geoip.load(path)
   local f = io.open(path, "r")
   if not f then return nil, "Load file not found." end
   local j=0
   while true do
      local l = f:read("*l")
      if l == nil then break end
      local i,t = 0,{}
      for m in gmatch(gsub(l,'"',''), '[^,]+') do
	 i = i+1
	 if i > 5 then break end
	 if i > 2 then t[i-2] = (i ~= 5 and tonumber(m)) or m end
      end
      j= j+1
      db[j] = t
   end
   f:close()
   mid = (#db%2==0 and #db/2) or (#db+1)/2
   return #db, nil
end

function geoip.find(ip,def)
   local dec,err = dec_ip(ip)
   if err ~= nil then return nil, err end
   local cur,low,upr = mid,1,#db
   local x,to,from = nil,nil,nil
   local j = 0
   while true do
      x = db[cur]
      from,to = x[1],x[2]
      if dec >= from and dec <= to then return x[3],nil end
      if dec > to then low = cur end
      if dec < to then upr = cur end
      cur = upr-low
      if cur == 1 then return def,nil end
      cur = low + ((cur%2==0 and cur/2) or (cur+1)/2)
      j = j + 1
   end
end

return geoip
