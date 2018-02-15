local inspect = require('inspect')

function nsIndex(tbl, space, maps)
   for key, value in pairs(tbl) do
      local ns = string.match(key, '^xmlns:(.+)')
      if ns then
	 if maps[value] then
	    space[maps[value]] = ns
	 end
      end
   end
end

function nsIndex2(tbl, space, maps)
   for key, value in pairs(tbl) do
      local xmlnsTry = string.sub(key, 1, 6)
      if xmlnsTry == 'xmlns:' then
	 local ns = string.sub(key, 7)
	 if maps[value] then
	    space[maps[value]] = ns
	 end
      end
   end
end

local xml = require("xml")

function soapExtract(dom)

   local nsMappings = {["urn:dslforum-org:cwmp-1-0"] = "cwmp",
      ["http://schemas.xmlsoap.org/soap/encoding/"] = "enc",
      ["http://schemas.xmlsoap.org/soap/envelope/"] = "env",
      ["http://www.w3.org/2001/XMLSchema"] = "xsd",
      ["http://www.w3.org/2001/XMLSchema-instance"] = "xsi"}
   
   local ns = {}
   nsIndex2(dom, ns, nsMappings)
   local header = xml.find(dom, ns["env"]..':Header')
   local body = xml.find(dom, ns["env"]..':Body')
   local idX = xml.find(header, ns["cwmp"]..':ID')
   -- local envelope = xml.find(dom, 'Envelope')

   local cwmp = body[1]
   local rpc = cwmp.xml
   local id = idX[1]
   
   ngx.say(rpc..': '..inspect(cwmp))
   
   -- ngx.say(inspect(ns))
end

local times = 1

local clock = os.clock
local open = io.open

local function read_file(path)
   local file = open(path, "rb") -- r read mode and b binary mode
   if not file then return nil end
   local content = file:read "*a" -- *a or *all reads the whole file
   file:close()
   return content
end

local xmlData = read_file('/home/foobar/resty/t/inform_thomson.xml')

ngx.say(xmlData)

local start = clock();
for i=times,1,-1 do
   local dom = xml.load(xmlData)
   -- xml.removeNamespace(dom, 'http://schemas.xmlsoap.org/soap/envelope/')
   soapExtract(dom)
   -- empty()
end
local stop = clock();

ngx.say('Helvetti: '..(stop-start))

-- ngx.say(xml.dump(dom))

-- local lub = require("lub")
-- local poor_guy = lub.search(dom, function(node)
--			       ngx.say('Node: '..node.xml)
--			       -- ngx.say(inspect(node))
--			       if node.xml == 'Person' and node.status == 'poor' then
--				  return node
--			       end
-- end)
