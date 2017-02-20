import socket
import sys


s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 建立连接:
s.connect(('127.0.0.1', 9000))
# 接收欢迎消息:
print(s.recv(1024).decode('utf-8'))

while True:
    data=input("send data:")
    if data == 'exit':
        break
    else:

        s.send(bytes(data,'utf-8'))
        print(s.recv(1024).decode('utf-8'))
s.send(b'exit')
s.close()