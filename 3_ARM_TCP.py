import os
import sys
import socket
import time

print len(sys.argv)
print "IP  :"+sys.argv[1]
print "PORT:"+sys.argv[2]

ip = sys.argv[1]
port = sys.argv[2]

command1 = '[123]version(0)\r\n'
command2 = '[123]io dir set(1,bit12=0)\r\n'
command3 = '[123]io set(1,bit12=1)\r\n'

port = int(port)

socket.setdefaulttimeout(10)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print sock.connect((ip,port))
print '<<<<<<<<<<<-start->>>>>>>>>'
sock.send((command1).encode())
time.sleep(1)
response = (sock.recv(1024).decode())
print response

sock.send((command2).encode())
time.sleep(1)
response = (sock.recv(1024).decode())
print response

sock.send((command3).encode())
time.sleep(1)
response = (sock.recv(1024).decode())
print response

sock.close()


# Detect = ':-)'
# total_data=''
# data=''
# while True:
# 	data = sock.recv(115200)
# 	total_data = total_data + data
# 	if Detect in data:
# 		#total_data = total_data + data
# 		break
# print total_data

# f = open(path, 'w')
# f.write(total_data)
# f.close()

