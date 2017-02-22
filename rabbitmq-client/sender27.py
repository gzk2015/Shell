import pika
from random import Random
import sys,os,time,random
import threading
import string


credent=pika.PlainCredentials("gadmin","123456")
conn_params = pika.ConnectionParameters("10.125.145.83" , credentials=credent,)
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()
channel.queue_declare(queue='hello',durable=True)

def random_char(y):
    return ''.join(random.choice(string.ascii_letters) for x in range(y))

def send_msg():
    i = 0
    while  i < 200:
        msg = random_char(20)
        i=i+1
        channel.basic_publish(exchange='',routing_key='hello',body=msg )
        print "[x] sent %s'"  % msg

while True:
    t=threading.Thread(target=send_msg())
    t.start()


conn.close()
