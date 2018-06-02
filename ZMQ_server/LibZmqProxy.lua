--print("< ".. tostring(CONFIG.ID).." console.LibZMQPort.lua > Load...")
local MODULE = {}

local zmq = require("lzmq")
local zpoller = require("lzmq.poller")
local TimeOut = 5000
local ZmqTable = {}
local context = zmq.context()

-- mode: REQ, REQ, SUB, PUB--
function MODULE.Connect(name, address, mode, timeout)
    if name then
        print("< LibZMQPort > Zmq_Create : name, address, mode, timeout : ", name, address, mode, timeout)

        local seq_zmq = nil
        if mode == "REQ" then
            seq_zmq, err = context:socket{zmq.REQ, connect = address}
            if timeout ~= nil then
                TimeOut = timeout
            end
            seq_zmq:set_rcvtimeo(TimeOut)
        elseif mode == "REP" then
            seq_zmq, err = context:socket(zmq.REP, {bind = address})
        elseif mode == "SUB" then
            seq_zmq, err = context:socket{zmq.SUB, connect = address, subscribe = ""}
        elseif mode == "PUB" then
            seq_zmq, err = context:socket(zmq.PUB, {bind = address})
        end
        print("seq_zmq, err#######: ", seq_zmq, err)
        zmq.assert(seq_zmq, err)
        ZmqTable[name] = seq_zmq

        return true
    end
end

function MODULE.Send(name, cmd)
    if name then
        local seq_zmq = ZmqTable[name]
        if seq_zmq then
            print("< LibZMQPort > _MODULE_Send_Cmd_ T : " .. string.format("%s\r\n", cmd));
            seq_zmq:send(cmd .. "\r\n")
            return true
        end
    end
end

function MODULE.Receive(name)
    if name then
        local seq_zmq = ZmqTable[name]
        if seq_zmq then
            local msg = seq_zmq:recv()
            print("< LibZMQPort > _MODULE_Receive_Cmd_ R : ", msg)
            return msg
        end
    end
end

function MODULE.SetTimeout(name,timeout)
    if name then
        local seq_zmq = ZmqTable[name]
        if seq_zmq then
            print("< LibZMQPort > _MODULE_Timeout_Cmd_ T : ", msg)
            seq_zmq:set_rcvtimeo(timeout)
            return true
        end
    end
end

function MODULE.SendCmd(name, cmd, timeout)
    if name then
        if timeout then MODULE.SetTimeout(name,timeout) end
        MODULE.Send(name, cmd)
        local ret  = MODULE.Receive(name)
        return ret
    end
end

return MODULE