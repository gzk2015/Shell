import pika
from random import Random
import sys,os,time,random
import threading
import string
from multiprocessing import Process

credent=pika.PlainCredentials("web_admin","gomeo2occ")
conn_params = pika.ConnectionParameters("g1rbmqv2.im.pro.gomeplus.com" , credentials=credent,)
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()
channel.queue_declare(queue='qunide',durable=True)

def random_char(y):
    return ''.join(random.choice(string.ascii_letters) for x in range(y))

def send_msg():
    i = 0
    while  i < 200:
        msg = random_char(20)
        i=i+1
        channel.basic_publish(exchange='',routing_key='hello',body=msg )
        print("[x] sent %s'"  % msg)

while True:
    t=threading.Thread(target=send_msg())
    t.start()


conn.close()
