#!/usr/bin/python
# -*- coding: UTF-8 -*-
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer
import os
import re

def kill_ftp(port):
    os.system('lsof -i:'+str(port)+'>a.txt')
    f = open("a.txt")
    lines = f.readlines()
    print(lines)
    if lines:
        print(lines)
        for line in lines:
            print(line)
            m = re.search('\s\d+\s',line)
            m = re.search('\d+',line)
            if m:
                print (m.group(0))
                cmd = "kill "+str(m.group(0)+"\n")
                os.system(cmd)
                print (cmd)
def main():
    authorizer = DummyAuthorizer()
    authorizer.add_user('user', '12345', '.', perm='elradfmwM')

    # authorizer.add_anonymous('/Users/mac/Desktop/Log/')              #此处添加一个匿名用户

    handler = FTPHandler                               #初始化处理客户端命令的类
    handler.authorizer = authorizer

    handler.banner = "pyftpdlib based ftpd ready."     #客户端连接时返回的字符串

    #handler.masquerade_address = '151.25.42.11'       #如果你在NAT之后，就用这个指定被动连接的参数
    #handler.passive_ports = range(60000, 65535)

    address = ('172.15.4.114', 2121)                        #设置服务器的监听地址和端口
    server = FTPServer(address, handler)


    server.max_cons = 256                              #给链接设置限制
    server.max_cons_per_ip = 5

    server.serve_forever()                             # 启动服务器

if __name__ == '__main__':
    kill_ftp('2121')
    main()