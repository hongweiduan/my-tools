# _*_ coding: utf-8 _*_
#!/usr/bin/python 
from Tkinter import *
import zmq 
import time
import os
import re
import csv
import copy
print("---------VERSION V0.01----------")
root = Tk()
root.title("Function Table Debug Tool")
voltage = StringVar()
e1 = Entry(root,textvariable=voltage)
e1.grid(row=0,column=5,padx=1,pady=2)
Label(root,text='V').grid(row=1,column=5)
curr = StringVar()
e2 = Entry(root,textvariable=curr)
e2.grid(row=2,column=5,padx=1,pady=2)
Label(root,text='mA').grid(row=3,column=5)
def send_cmd(function_name,param1,param2,unit,timeout):
	global tcp_ip
	if timeout == None or timeout == "":
		timeout = 3000
	# print("tcp ip is >>"+str(tcp_ip))
	context = zmq.Context()
	socket = context.socket(zmq.REQ)
	socket.connect(tcp_ip)
	if param2 == "VOLTAGE":
		print("Set voltage :" + e1.get() + "V")
		socket.send('{\"id\":\"f143164097ff11e58c6d3c15c2dab3ba\",\"method\":\"'+function_name+'\",\"jsonrpc\":\"2.0\",\"args\":[\"'+param1+'\",\"'+e1.get()+'\"],\"kwargs\":{\"timeout\":'+timeout+',\"unit\":\"'+unit+'\"}}')
	elif param2 == "ELOAD":
			socket.send('{\"id\":\"f143164097ff11e58c6d3c15c2dab3ba\",\"method\":\"'+function_name+'\",\"jsonrpc\":\"2.0\",\"args\":[\"'+param1+'\",\"'+e2.get()+'\"],\"kwargs\":{\"timeout\":'+timeout+',\"unit\":\"'+unit+'\"}}')
	else:
		socket.send('{\"id\":\"f143164097ff11e58c6d3c15c2dab3ba\",\"method\":\"'+function_name+'\",\"jsonrpc\":\"2.0\",\"args\":[\"'+param1+'\",\"'+param2+'\"],\"kwargs\":{\"timeout\":'+timeout+',\"unit\":\"'+unit+'\"}}')
	response = socket.recv()
	# print (response)  
	response_pattern = re.compile('\"result\":(.+)')
	result = response_pattern.search(response)
	if result != None:
		print ("Result>>>" + result.group(1))
	else:
		print ("Result>>>" + response)

	response += '\r'
	global all_response
	all_response +=response

def get_a_button():
	global button_name,button_num,button_dict
	local_csv = copy.copy(button_dict[button_name])
	button_name = button_name[:15]
	# Button(root,text=button_name,width=len(button_name),command=lambda:run_script(local_csv)).grid(row=button_num/4,column=button_num%4)
	Button(root,text=button_name,width=13,command=lambda:run_script(local_csv)).grid(row=button_num/4,column=button_num%4)


def parse_csv():
	path_list = os.listdir(os.getcwd()+'/test_plan')
	print(path_list)
	global button_dict,button_name,button_num
	button_num = 4
	for x in xrange(0,len(path_list)):
		tp_name = path_list[x]
		# print(tp_name.find(".csv"))
		if tp_name.find(".csv") > 0:
			print(tp_name)
			button_name = re.match("(.*)__",tp_name).group(1)
			print(button_name)
			button_dict[button_name]=tp_name
			print(button_num/2,button_num%2)
			get_a_button()
			button_num +=1
# print(os.path.realpath(__file__))
# print(os.path.split(os.path.realpath(__file__)))
# print(os.getcwd())

def run_script(local_csv):
	# global button_dict,button_name
	print("==================="+local_csv+"===================")
	with open(os.getcwd()+'/test_plan/'+local_csv,"rb") as csvtp:
		tp = csv.DictReader(x.replace('\0', '') for x in csvtp)
		for row in tp:
			# print("------------------- TID -------------------------")
			# print(row['TID'],row['FUNCTION'], row['PARAM1'],row['PARAM2'],row['UNIT'],row['TIMEOUT'])
			print(row['TID'])
			send_cmd(row['FUNCTION'], row['PARAM1'],row['PARAM2'],row['UNIT'],row['TIMEOUT'])
tcp_ip = "tcp://127.0.0.1:6100"
def set_tcp_ip(x):
	global tcp_ip
	print(x)
	tcp_ip = tcp_ip[:-1]+str(x)
	print("tcp_ip is >>>" + tcp_ip)
def add_uut_button():
	# for i in xrange(0,4):
		# x = copy.copy(i)
	uut = IntVar()
	Radiobutton(root,text="UUT0",variable=uut,value=0,command=lambda:set_tcp_ip(0)).grid(row=0,column=0)
	Radiobutton(root,text="UUT1",variable=uut,value=1,command=lambda:set_tcp_ip(1)).grid(row=0,column=1)
	Radiobutton(root,text="UUT2",variable=uut,value=2,command=lambda:set_tcp_ip(2)).grid(row=0,column=2)
	Radiobutton(root,text="UUT3",variable=uut,value=3,command=lambda:set_tcp_ip(3)).grid(row=0,column=3)
	# Button(root,text=str("UUT1"),width=len(str(x)),command=lambda:set_tcp_ip(0)).grid(row=0,column=0)
	# Button(root,text=str("UUT2"),width=len(str(x)),command=lambda:set_tcp_ip(1)).grid(row=0,column=1)
	# Button(root,text=str("UUT3"),width=len(str(x)),command=lambda:set_tcp_ip(2)).grid(row=0,column=2)
	# Button(root,text=str("UUT4"),width=len(str(x)),command=lambda:set_tcp_ip(3)).grid(row=0,column=3)
def main():
	global all_response,button_dict,button_name,button_num
	all_response = ""
	button_dict = {}
	button_name = ""
	add_uut_button()
	parse_csv()
	print(button_dict)
	mainloop()
main()
