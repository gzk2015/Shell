import socket
import threading
import time
from urllib import request


s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

s.bind(('127.0.0.1',9000))
s.listen(5)
print("waiting for connection...")

def tcplink(sock,addr):
    print("Accept new connecton from %s:%s ..."  % addr)
    sock.send(b'Welcome!')
    while True:
        data = sock.recv(1024)
        time.sleep(1)
        if not data or data.decode('utf-8') == 'exit':
            break
        sock.send(('hello,%s' % data.decode('utf-8')).encode('utf-8'))
        print('recive %s from %s:%s' % (data , addr[0], addr[1]))
        if data.decode('utf-8') == "startie":
            a=request.urlopen("http://www.baidu.com").readlines()
            print(a)
    sock.close()
    print("connection from %s:%s close" %addr)

while True:
    sock,addr = s.accept()
    t=threading.Thread(target=tcplink,args=(sock,addr))
    t.start()

