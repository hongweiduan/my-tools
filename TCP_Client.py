import telnetlib
import time

HOST ="169.254.1.35"
tn=telnetlib.Telnet(HOST,"7600")
tn.open(HOST,"7600")
time.sleep(2)
tn.write("[123]version(0)\r\n")

cmd_socket_log = ""
for x in xrange(1,10):
    time.sleep(0.01)
    cmd_socket_log += str(tn.read_eager())

print("Respose",cmd_socket_log)