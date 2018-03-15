f = io.popen('ls')
local save_csv_name = "data_summary.csv"
local project_name = "A245"
ls_str = f:read("*all")
f:close()

if string.find(ls_str,save_csv_name) then
	return 'pass'
end

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
-- print(file_name[15])
for i=1,#file_name do
	file_name[i] = string.gsub(file_name[i],"\r","")
	file_name[i] = string.gsub(file_name[i],"\n","")
	-- print(file_name[i])
	if string.find(file_name[i],".csv") then 
		local f = io.open(file_name[i],'r')
		file_str = f:read("*all")
	-- for i=1,#file_str do
		if string.find(file_str,'Upper Limited') then
			file_str_head = string.match(file_str,"(.-)"..project_name)
			ffff:write(file_str_head)
			break
		end
	end
	-- end
	-- end
end


for i=1,#file_name do
	file_name[i] = string.gsub(file_name[i],"\r","")
	file_name[i] = string.gsub(file_name[i],"\n","")
	print(file_name[i])
	local f = io.open(file_name[i],'r')
	file_str = f:read("*all")
	-- print(file_str)
	file_str = split(file_str,'\n')
	for j=1,#file_str do
		if string.find(file_str[j], project_name..'%,') then
			-- print(file_str[i])
			ffff:write(tostring(file_str[j])..'\n')
			-- break
		end
	end
end

ffff:close()