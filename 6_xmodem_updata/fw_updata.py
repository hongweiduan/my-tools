import argparse
import serial
import time
from xmodem import XMODEM
import os

def xmodem_dl(port, baudrate, file):
	ser = serial.Serial(port,baudrate,timeout=1)
	def getc(size, timeout=1):
	    time.sleep(0.05)
	    return ser.read(size) or None
	
	def putc(data, timeout=1):
	    time.sleep(0.05)
	    return ser.write(data)
	putc('version\r\n')
	time.sleep(0.1)
	old_ver = getc(30)
	print('----old FW version is:'+old_ver)
	time.sleep(0.1)
	putc('updata\r\n')
	time.sleep(0.1)
	c = getc(13)
	print(c)
	modem = XMODEM(getc, putc,mode = 'xmodem1k')
	stream = open(file, 'rb')
	state = modem.send(stream)
	if state:
		dl_str = getc(100)
		print(dl_str)
		print("--success--")
	else:
		dl_str = getc(10)
		print("--fail--")

if __name__ == '__main__':
	bin_name = "ARM.bin"
	path_list = os.listdir('.')
	for x in path:
		if x.find('.bin')!= -1:
			bin_name = x
			print('bin file name is >>>' + x)
			break
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--port', help='serial port', type=str)
    parser.add_argument('-b', '--baudrate', help='serial baudrate', type=int, default=115200)
    parser.add_argument('-f', '--file', help='farmware file path', type=str, default=bin_name)
    args = parser.parse_args()

    port = args.port
    baudrate = args.baudrate
    file = args.file

    xmodem_dl(port, baudrate, file)
    raw_input()
