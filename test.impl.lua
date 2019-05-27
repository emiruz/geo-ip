local rnd = math.random
local G = require 'geoip'

local function time(f, desc)
   s = os.clock()
   f()
   e = os.clock()
   print("DESC: " .. desc .. '\t' .. e-s .. 's')
end

time(function()
      cnt, err = G.load("ipdb.csv")
      assert(err == nil)
end, "DB load")

time(function()
      for i=1,100000 do
	 local ip = string.format("%d.%d.%d.%d",
				  rnd(1,256),rnd(1,256),
				  rnd(1,256),rnd(1,256))
	 local country,err = G.find(ip,"N/A")
      end
     end, "100000 random IPs")


   
