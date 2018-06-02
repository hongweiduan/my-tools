local lapp = require("pl.lapp")
print("----------TestPlanTool V1.0------------")
local args = lapp [[
Test plan Tool

This is a tool to create the csv testplan.
raw testplan support 
   1.skip items.
   2.Add doc or comment.
   3.Add index for items.
   4.show the important items.
   5.key words to mark items.
    
   -f,--file       (default example__1V0.testplan)          The raw testplan path.
   -i,--index                                               Need index for each items?
   -b,--backup                                              Need backup old testplan?
]]



local test_plan = args.file
local current_path,file_name = string.match(test_plan,"(.+)%/(.*)")
local testplan_name = "Test_Plan"
if string.match(file_name,"(.+)%_%_(.+)%.") then
   testplan_name,CsvVersion = string.match(file_name,"(.+)%_%_(.+)%.")
else
   testplan_name = string.match(file_name,"(.+)%.")
end
-- local Version = ArgVersion or CsvVersion or "NoVersion"
local test_plan_new = current_path.."/"..testplan_name.."__"..CsvVersion..".csv"

local successFlag = true
local keyWords = {
   -- group = "group",
   -- tid = "name",
   -- function_name = "func",
   -- description = "note",
   -- high = "high",
   -- low = "low",
   -- unit = "unit",
   -- param1 = "param1",
   -- param2 = "param2",
   -- timeout = "timeout",
   -- key = "key",
   -- val = "val",

   group = "g",
   tid = "n",
   function_name = "f",
   description = "d",
   high = "h",
   low = "l",
   unit = "u",
   param1 = "p1",
   param2 = "p2",
   timeout = "t",
   key = "k",
   val = "v",

   important_character = "%*%*",
   start_character = ":",
   stop_character = ",",
   skip_character = "%-%-",
   doc_character = "%/%/",
   tag_character = "^%#(.-)%#",
}


local default = {
   group = "group",
   tid = "Items",
   function_name = "fixture.skip",
   description = "",
   high = "",
   low = "",
   unit = "",
   param1 = "",
   param2 = "",
   timeout = 3000,
   key = "",
   val = "",
}

local ruler = require("ruler")
local IsNeedCheckRPC= ruler.get_RPC_LOG(current_path)
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

function parser(line_str,key)
   local ret = string.match(line_str,keyWords[key]..keyWords.start_character.."%s*(.-)%s*"..keyWords.stop_character) or default[key] or ""
   return ret
end

function parseChecker(line_str,key )
   return string.match(line_str,keyWords[key]..keyWords.start_character.."%s*(.-)%s*"..keyWords.stop_character)
end

function FormatName(name)
   local ret = string.gsub(name," ","_")
   ret = string.upper(ret)
   return ret
end

-- function GetVersion(v)

-- end

function modifyTestPlan(v,line_num)
   -------- modify the testplan --------
   -------------------------------------
   --mark important items
   if string.match(v,keyWords.important_character) ~= nil then
      group = string.gsub(group,keyWords.important_character,"")
      group = string.gsub(group,"^%s*(.-)%s*$","%1")
      tid = "*"..string.gsub(FormatName(tid),'^%d*_',"")
   end
   --check function
   if string.match(v,keyWords.skip_character) ~= nil then
      -- print(v)
      function_name = default.function_name
      low = default.low
      high = default.high
      group = string.gsub(group,keyWords.skip_character,"")
      group = string.gsub(group,"^%s*(.-)%s*$","%1")
   end
   if string.match(v,keyWords.tag_character) ~= nil then
      local now_tag = string.match(v,keyWords.tag_character) or "NA"
      if now_tag ~= setting_tag then
         return
      else
         group = string.gsub(group,keyWords.tag_character,"")
         group = string.gsub(group,"^%s*(.-)%s*$","%1")
      end
   end
   -- print(function_name)
   if IsNeedCheckRPC then
      if ruler.checkFuncRpc(function_name) == false then
         print("FAIL>>>>Line"..line_num..":function <"..function_name.."> not in RPC list!")
         successFlag = false
      end
   end
   -- timeout to setting timeout
   if (tonumber(timeout) and  tonumber(timeout) > tonumber(default.timeout)) == false then
      timeout = default.timeout 
   end
   --add items index & upper tid
   if args.index then
      tid = tostring(index).."_"..string.gsub(FormatName(tid),'^%d*_',"")
   else
      tid = string.gsub(FormatName(tid),'^%d*_',"")
   end
   --upper group 
   group = FormatName(group)
   -- remove description
   description = ""
   ---------------------------------------------
   ---------------------------------------------
   new_line = tostring(group)..','..tostring(string.gsub(tid," ",""))..','..tostring(description)..','..tostring(function_name)..','..tostring(timeout)..','..tostring(param1)..','..tostring(param2)..','..tostring(unit)..','..tostring(low)..','..tostring(high)..','..tostring(key)..','..tostring(val)
   new_test_plan = new_test_plan .. "\n" .. new_line
   index = index + 1
end

function testplanToTestPlan(v,line_num)
   if string.match(v,"GROUP%,TID%,") ~= nil then
      -- print(v)
      new_test_plan = v
   end
   if string.match(v,"GROUP%,TID%,") == nil and string.match(v,"%,")~= nil then
      list = split(v,",")
      group = list[1] or ""
      tid   = list[2] or ""
      description = list[3] or ""
      function_name = list[4] or ""
      timeout  = list[5] or ""
      param1 = list[6] or ""
      param2 = list[7] or ""
      unit = list[8] or ""
      low = list[9] or ""
      high = list[10] or ""
      key = list[11] or ""
      val = list[12] or ""
      modifyTestPlan(v,line_num)
   end
end

function strToTestPlan(v,line_num)
   if string.match(v,keyWords.group) ~= nil then
      group = parser(v,"group")
   end
   if string.match(v,keyWords.tid) ~= nil then
      tid = parser(v,"tid")
      description = parser(v,"description")
      function_name = parser(v,"function_name")
      timeout = parser(v,"timeout")
      param1 = parser(v,"param1")
      param2 = parser(v,"param2")
      unit = parser(v,"unit")
      low = parser(v,"low")
      high = parser(v,"high")
      key = parser(v,"key")
      val = parser(v,"val") 
      modifyTestPlan(v,line_num)
   end
end

local f = io.open(test_plan,'r+')
file_str = f:read("*all")
f:close()

local log_tab = split(file_str,'\n')
new_test_plan = "GROUP,TID,DESCRIPTION,FUNCTION,TIMEOUT,PARAM1,PARAM2,UNIT,LOW,HIGH,KEY,VAL"
index = 1
for i,v in ipairs(log_tab) do
   if string.match(v,keyWords.doc_character) == nil  then
      if string.match(v,"tag%:%<%<(.*)%>%>") then
         setting_tag = string.match(v,"tag%:%<%<(.*)%>%>")
         testplan_name = testplan_name .."_".. setting_tag
         print(">>>>Tag:"..setting_tag)
      elseif string.match(v,"version%:%<%<(.*)%>%>") then
         TestPlanVer = string.match(v,"version:%<%<(.*)%>%>")
         print(">>>>Version:"..TestPlanVer)
         test_plan_new = current_path.."/"..testplan_name.."__"..CsvVersion.."_"..TestPlanVer..".csv"
      elseif string.match(v,"args%:%<%<(.*)%>%>") then
         local args_str = string.match(v,"args:%<%<(.*)%>%>")
         print(">>>>redefine args_str:"..args_str)
         if string.match(args_str,"%-i") then args.index = true else args.index = false end
         if string.match(args_str,"%-b") then args.backup = true else args.backup = false end
         local arg_timeout = string.match(args_str,"%-t (%d*)")
         if arg_timeout then default.timeout = arg_timeout end          
      elseif #split(v,",") < 11 and parseChecker(v,"tid") or parseChecker(v,"group")  then
         strToTestPlan(v,i)
      elseif #split(v,",") >= 11 then
         testplanToTestPlan(v,i)
      elseif string.match(v,"%S") == nil then
      else
         print("FAIL>>>>Line"..i.." not a right format for test sequence!")         
      end
   end
end

function bkTestPlan( Test_Plan_Path )
   local DicPath = string.match(Test_Plan_Path,"(.+)/.*")
   local f = io.popen('ls -S '..(DicPath or "")) 
   lsStr = f:read("*all")
   f:close()
   fileName = split(lsStr,'\n')
   for i=1,#fileName do
      if fileName[i] then
         if string.match(fileName[i],"%.csv") then
            local nowCSVPath = DicPath.."/"..fileName[i]
            if string.match(nowCSVPath,CsvVersion.."_"..TestPlanVer)== nil then
               os.execute('mkdir -p '..DicPath.."/bk/")
               os.execute('mv '..nowCSVPath.." "..DicPath.."/bk/"..fileName[i])
            end
         end
      end
   end
   return true
end
if args.backup then
   bkTestPlan(args.file)
end
if successFlag == false then 
   return false
end
local ff = io.open(test_plan_new,'w+')
ff:write(new_test_plan)
ff:close()