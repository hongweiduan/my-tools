local zmq = require("LibZmqProxy")

local Name = "PUB1"



zmq.Connect(Name,"tcp://127.0.0.1:7100","PUB",5000)
os.execute("sleep 1")
local ret = zmq.SendCmd(Name, "start",50000)
print(ret)
os.execute("sleep 1")
local ret = zmq.SendCmd(Name, "end",50000)
print(ret)
-- while 1:
--     local ret = zmq.Receive(Name)
--     if ret then
--         print(ret)
--         zmq.Send(Name, "cmd")
--     else
--         os.execute("sleep 1")
--     end

