local ruler = {}
local RPC_LOG = ""
function ruler.get_RPC_LOG(current_path)	
	if string.match(current_path,"%/Profile") then
	   local TM_path = string.match(current_path,"(.+)%/Profile")
	   local Function_RPC_path = tostring(TM_path).."/LuaDriver/Driver/Function_RPC.lua" 
	   local f = io.open(Function_RPC_path,"r+")
	   if f then
	      	RPC_LOG = f:read("*all")
	      	f:close()
	      	return true
		else
			return false
	   end
	end
	return false
end


function ruler.checkFuncRpc(func)
	if string.match(string.lower(RPC_LOG),"%s"..string.lower(func).."%s") ~= nil then
		return true
	else
		return false
	end
end

return ruler
