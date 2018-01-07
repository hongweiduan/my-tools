import serial
import time
from xmodem import XMODEM
# # Protocol bytes
# SOH = b'\x01'
# STX = b'\x02'
# EOT = b'\x04'
# ACK = b'\x06'
# DLE = b'\x10'
# NAK = b'\x15'
# CAN = b'\x18'
# CRC = b'C'




# def xmodem_send(serial, file):
#     t, anim = 0, '|/-\\'
#     # serial.setTimeout(1)
#     while 1:
#     	ser_str = serial.read(1)
#         print(ser_str)
#         if ser_str != CRC:
#             t = t + 1
#             # print anim[t%len(anim)],'\r',
#             time.sleep(0.3)
#             if t == 60 : return False
#         else:
#             break
    
#     p = 1
#     s = file.read(128)
#     print s
#     while s:
#         s = s + '\xFF'*(128 - len(s))
#         chk = 0
#         for c in s:
#             chk+=ord(c)
#         while 1:
#             serial.write(SOH)
#             serial.write(chr(p))
#             serial.write(chr(255 - p))
#             serial.write(s)
#             serial.write(chr(chk%256))
#             serial.flush()
    
#             answer = serial.read(1)
#             if  answer == NAK: continue
#             if  answer == ACK: break
#             return False
#         s = file.read(128)
#         p = (p + 1)%256
#         print '.',
#     serial.write(EOT)
#     return True

ser = serial.Serial('/dev/cu.usbserial-A600UN7X',115200,timeout=1)
def getc(size, timeout=1):
    time.sleep(0.05)
    return ser.read(size) or None

def putc(data, timeout=1):
    time.sleep(0.05)
    return ser.write(data)

a = putc('version\r\n')
# print(a)
time.sleep(0.1)
ver = getc(20)
print(ver)

# print ser.name

# getc(10)
# ser.close()
time.sleep(1)
# ser.open()
a = putc('updata\r\n')
print(a)
time.sleep(0.1)
a = getc(13)
# a = ser.read(1)
print(a)
# print(a == CRC)
# ser.close()
modem = XMODEM(getc, putc,mode = 'xmodem1k')

# stream = open('ARM_S_V03_171104.bin', 'rb')
stream = open('ARM_S_V03_171106.bin', 'rb')
a = modem.send(stream)
# a = xmodem_send(ser,stream)
print(a)
