local zmq = require("LibZmqProxy")

local Name = "PUB0"



zmq.Connect(Name,"tcp://127.0.0.1:7100","SUB",5000)

local state = "waiting"
while 1 do
    local ret = zmq.SendCmd(Name,state,5000)
    print("---------------------")
    print(state)
    print("---------------------")
    if ret then
        if state == "waiting" then
            if string.match(ret,"start") then
                state = "running"
                print("<<<<<running>>>>")
                local rec = zmq.SendCmd(Name,"running",500)
                if string.match(rec,"OK")== nil then
                    error("Fail send OK to start running")
                end
            end
            -- else ret == "end" then
        else
            if string.match(ret,"end") then
                state = "waiting"
                print(">>>>>waiting<<<<<<")
                local ret = zmq.SendCmd(Name,"stop",500)
            end
        end
    --     zmq.Send(Name, "cmd")
    -- else
    --     os.execute("sleep 1")
    end
end
