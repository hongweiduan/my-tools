hwio_cmd_path = "HWIO_CMD.csv"
local function GetCmd(t)
    local count = #t.IO
    local cmd = "io set(" .. count
    local b, s = 1, 2
    for i = 1, count do
        local bit = "bit" .. t.IO[i][b]
        local state = t.IO[i][s]
        cmd = cmd .. "," .. bit .. "=" .. state
    end
    cmd = cmd .. ")"
    
    return cmd
end
HWIO = require("HWIO")
local str = ""
str = str .. HWIO.Version.."\r"

for TableName,Table in pairs(HWIO) do
    print(TableName,Table)
    if TableName == "RelayTable" then
        str = str ..TableName..":\r"
        for NetName,NetTab in pairs(Table) do
            -- print(NetName,NetTab)
            for ConnOrDisConn,IoTab in pairs(NetTab) do
                -- print(ConnOrDisConn,IoTab)
                str = str ..",".. NetName..","..ConnOrDisConn..",\""..GetCmd(IoTab).."\"\r"
            end
        end
        -- print("---"..TableName)
    elseif tostring(type(Table)) == "table" then  
        str = str ..TableName..":\r"
        for NetName,NetTab in pairs(Table) do
            -- print(NetName,NetTab)
            -- for ConnOrDisConn,IoTab in pairs(NetTab) do
                -- print(ConnOrDisConn,IoTab)
            if NetTab.IO then
                str = str ..",".. NetName..",,\""..GetCmd(NetTab).."\"\r"
            end
            -- end
        end
        -- print("-->"..TableName)
    end
end
local x = assert(io.open(hwio_cmd_path,"w+"))
-- local str = ""
-- str = str .. HWIO.Version.."\r"
-- -- print(HWIO.Version)

-- str = str .."MeasureTable:\r"
-- for i,v in pairs(HWIO.MeasureTable) do
--     str = str..i..","..GetCmd(v).."\r"
--     print(i,GetCmd(v))
-- end

-- str = str .."MeasureTable:\r"
-- for i,v in pairs(HWIO.MeasureTable) do
--     str = str..i..","..GetCmd(v).."\r"
--     print(i,GetCmd(v))
-- end


-- print(str)
x:write(str)
x:close()