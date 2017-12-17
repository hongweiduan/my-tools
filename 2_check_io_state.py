# encoding  utf-8

import telnetlib
import time
import re
# output_log = '[1]ACK(frequency: 1971.65718349Hz,rms: 11.0342178885mV;DONE;2183,442,2183,637,195)'
# measure_value = re.search('rms: (.*)mV',output_log)

# print(measure_value.group(1))
HOST ="192.168.66.23"
tn=telnetlib.Telnet(HOST,"7600")
tn.open(HOST,"7600")
tn.set_debuglevel(9)
time.sleep(2)
tn.write("[123]version(0)\r\n")
# time.sleep(2)
# tn.write("[123]io set(1,bit12=1)" +"\nHost:"+str(HOST)+ "\n\n")
# tn.write("GET"+"\n\n")
time.sleep(2)
print 'printing...'
socket_log = "" 

for CNT in range(10):
    time.sleep(0.001)
    strout = str(tn.read_eager())
    # print str(CNT) + ' -- ' + str(len(strout)) + '--' + str(strout)
    socket_log += strout
def send_cmd(tn,cmd):
	tn.write(cmd+"\r\n")
	time.sleep(0.5)
	cmd_socket_log = ""
	for CNT in range(10):
	    time.sleep(0.001)
	    strout = str(tn.read_eager())
	    # print str(CNT) + ' -- ' + str(len(strout)) + '--' + str(strout)
	    cmd_socket_log += strout
	time.sleep(0.5)
	return cmd_socket_log	
# strout = str(tn.read_eager())
# socket_log += strout
# print("***********************")
# print(socket_log)
# print("**********************")
output_log = "SET,MEAS"
output_csv = "BIT,state"

# send_cmd(tn,"[11]io set(2,bit44=1,bit37=1)")
for x in xrange(20,1001,20):
	meas_log = send_cmd(tn,"[11]io read(1,bit"+str(x)+")")
	# meas_log = send_cmd(tn,"[1]audio measure(-fm)")
	# output_log = output_log + '\nSET rms is ' + str(x) + " mV, measure log is "+ meas_log
	measure_value = re.search('ACK\((.*)\)',meas_log)
	output_csv = output_csv + '\n'+str(x) + ','+ str(measure_value.group(1))
print("***********************")
print(output_csv)
print("**********************")



# send_cmd(tn,"[1]audio output disable()")
# send_cmd(tn,"[11]io set(2,bit44=0,bit37=0)")
tn.close()