# _*_ coding: utf-8 _*_
from Tkinter import *
import zmq 
import time
root = Tk()
root.title("Function Table Debug Tool")
Label(root,text='function:').grid(row=0,column=0) # 对Label内容进行 表格式 布局
Label(root,text='param1:').grid(row=0,column=2)
Label(root,text='param2:').grid(row=0,column=5)
Label(root,text='unit:').grid(row=0,column=7)
 
v1=StringVar()    # 设置变量 . 
v2=StringVar()
v4=StringVar()
v5=StringVar()
e1 = Entry(root,textvariable=v1)            # 用于储存 输入的内容  
e2 = Entry(root,textvariable=v2)            # 用于储存 输入的内容  
e4 = Entry(root,textvariable=v4)            # 用于储存 输入的内容  
e5 = Entry(root,textvariable=v5)            # 用于储存 输入的内容  
# e2 = Entry(root,textvariable=v2,show='$')
e1.grid(row=0,column=1,padx=10,pady=5)      # 进行表格式布局 . 
e1.focus()
e2.grid(row=0,column=3,padx=10,pady=5)
e4.grid(row=0,column=6,padx=10,pady=5)
e5.grid(row=0,column=8,padx=10,pady=5)

v3=StringVar()
e3 = Label(root,textvariable=v3)
e3.grid(row=1,columnspan = 7,padx=10,pady=5)
all_response = ""
count = 0
def show():
	global all_response
	context = zmq.Context()
	socket = context.socket(zmq.REQ)
	socket.connect("tcp://127.0.0.1:6100")
	socket.send('{\"id\":\"f143164097ff11e58c6d3c15c2dab3ba\",\"method\":\"'+e1.get()+'\",\"jsonrpc\":\"2.0\",\"args\":[\"'+e2.get()+'\",\"'+e4.get()+'\"],\"kwargs\":{\"timeout\":5000,\"unit\":\"'+e5.get()+'\"}}')
	response = socket.recv();
	print (response)  
	print ("Received request: ", response)
	response += '\r'
	all_response +=response
	v3.set(all_response) 
    
    # print("帐号 :%s" % e1.get())    
    # print("密码 :%s" % e2.get())

Button(root,text='send',width=3,command=show).grid(row=0,column=4,sticky=W,padx=6,pady=3)  # 设置 button 指定 宽度 , 并且 关联 函数 , 使用表格式布局 . 
# Button(root,text='退出',width=10,command=root.quit).grid(row=3,column=1,sticky=E,padx=10,pady=5)

mainloop()
