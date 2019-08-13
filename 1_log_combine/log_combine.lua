local lapp = require("pl.lapp")
print("----------TestPlanTool V1.0------------")
local args = lapp [[
Log Combine Tool

   -p,--project       (default B515)                        The project name in csv name.
   -o,--output        (default data_summary.csv)            Output file name.
   -s,--skipempty                                           Need skip the empty cell log for opp tools?
   -i,--input         (default local)                    	Input floder of CSV.
]]
f = io.popen('ls -Sl')
local save_csv_name = args.output
local project_name = args.project
ls_str = f:read("*all")
f:close()

if string.find(ls_str,save_csv_name) then
	return 'pass'
end

local ItemNum = 0

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

file_name = split(ls_str,'\n')

local ffff = io.open(save_csv_name,'w+')
-- print(file_name[2])
local true_file_str_head = ""
for i=1,#file_name do
	file_name[i] = string.match(file_name[i]," ("..project_name..".*%.csv)") or ""
	file_name[i] = string.gsub(file_name[i],"\r","")
	file_name[i] = string.gsub(file_name[i],"\n","")
	-- print(file_name[i])
	if string.find(file_name[i],".csv") then 
		local f = io.open(file_name[i],'r')
		file_str = f:read("*all")
	-- for i=1,#file_str do
		if string.find(file_str,'Upper Limited') then
			file_str_head = string.match(file_str,"(.-)"..project_name)
			local HeadLine = split(file_str_head,"\n")
			local ItemTab = split(HeadLine[1],",")
			NowItemNum = #ItemTab
			print("ItemNum>>"..ItemNum)
			if NowItemNum > ItemNum then
				ItemNum = NowItemNum
				true_file_str_head= file_str_head
			end
			-- break
		end
	end
	print(">>>>>"..ItemNum)	-- end
	-- end
end
	ffff:write(true_file_str_head)


for i=1,#file_name do
	-- file_name[i] = string.match(file_name[i]," ("..project_name..".*%.csv)") or ""
	file_name[i] = string.gsub(file_name[i],"\r","")
	file_name[i] = string.gsub(file_name[i],"\n","")
	print(file_name[i])
	if string.find(file_name[i],".csv") then 
	local f = io.open(file_name[i],'r')
	file_str = f:read("*all")
	-- print(file_str)
	file_str = split(file_str,'\n')
	for j=1,#file_str do
		if string.find(file_str[j], project_name..'%,') then
			-- print(file_str[i])
			local NowLineNum = #(split(file_str[j],","))
			print("NowLineNum>>"..NowLineNum)
			if args.skipempty == false or NowLineNum == ItemNum then
				ffff:write(tostring(file_str[j])..'\n')
			end
		end
	end
	end
end

ffff:close()