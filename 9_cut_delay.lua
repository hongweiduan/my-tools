local lapp = require("pl.lapp")

local args = lapp [[
lua cut delay tool

This is a tool to cut the delay time in lua script.
    
    -f,--file       (default dmm.lua)               The script to cut delay.
    -s,--scale      (default 0.5)                   The scale of delay cut.
]]

if args.file ~= nil then
	-- print(args.file)
	-- print(args.scale)
	local path = args.file
	local f = io.open(args.file,'r+')
	criptDetails= f:read("*all")
	f:close()
	local str = criptDetails
	local new_str = ""
	local s = args.scale
	local index = 1
	while 1 do
		local __str = string.sub(str,index,#str)
		local start_num,end_num,find_str = string.find(__str,"delay%((%d*)%)")
		if start_num == nil then
			new_str = new_str .. string.sub(str,index,#str)
			break
		else
			local _str = string.sub(str,index,index+end_num-1)
			new_str = new_str ..string.gsub(_str,"delay%("..find_str.."%)","delay("..tostring(find_str*s)..")")
			index = index+end_num
		end
	end

	-- path = "/Users/mac/Desktop/dmm.lua"

	-- print(path)

	local current_path,lua_name = string.match(path,"(.+)%/(.*)")
	-- print(current_path)
	os.execute('mkdir '..current_path.."/NEW_SCRIPT/")
	local new_script_path = current_path.."/NEW_SCRIPT/"..lua_name
	local ff = io.open(new_script_path,'w+')
	ff:write(new_str)
	ff:close()

	print ("Please update new script in :"..new_script_path)
	print ("Successful!!!")
end



