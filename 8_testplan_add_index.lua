local test_plan = "IN755_FCT__1V18g.csv"
local test_plan_new = "IN755_FCT__1V19.csv"

function split(str, pat)
   local t = {}
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

local f = io.open(test_plan,'r+')
file_str = f:read("*all")
-- print(file_str)
f:close()

local log_tab = split(file_str,'\n')
local new_test_plan = ""
local index = 1
for i,v in ipairs(log_tab) do
   if string.match(v,"GROUP%,TID%,") ~= nil then
      -- print(v)
      new_test_plan = v
   end
   if string.match(v,"GROUP%,TID%,") == nil and string.match(v,"%,")~= nil then
      local list = split(v,",")
      local group = list[1] or ""
      local tid   = list[2] or ""
      local description = list[3] or ""
      local function_name = list[4] or ""
      local timeout  = list[5] or ""
      local param1 = list[6] or ""
      local param2 = list[7] or ""
      local unit = list[8] or ""
      local low = list[9] or ""
      local high = list[10] or ""
      local key = list[11] or ""
      local val = list[12] or ""
      -------- modify the testplan --------
      -------------------------------------
      --add items index & upper tid

      tid = tostring(index).."_"..string.upper(string.gsub(tid,'^%d*_',""))

      --upper group 
      group = string.upper(group)

      -- remove description
      description = ""
      ---------------------------------------------
      ---------------------------------------------
      new_line = tostring(group)..','..tostring(string.gsub(tid," ",""))..','..tostring(description)..','..tostring(function_name)..','..tostring(timeout)..','..tostring(param1)..','..tostring(param2)..','..tostring(unit)..','..tostring(low)..','..tostring(high)..','..tostring(key)..','..tostring(val)
      new_test_plan = new_test_plan .. "\n" .. new_line
      index = index + 1
   end
end

print(new_test_plan)

local ff = io.open(test_plan_new,'w+')
ff:write(new_test_plan)
ff:close()