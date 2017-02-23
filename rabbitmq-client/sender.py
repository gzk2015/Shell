import pika
from random import Random
import sys,os,time,random
import threading
import string
import multiprocessing
import time

credent=pika.PlainCredentials("gtadmin","123456")



conn_params = pika.ConnectionParameters("10.125.145.81" , credentials=credent,)
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()
channel.queue_declare(queue='qunide',durable=True)

def random_char(y):
     return ''.join(random.choice(string.ascii_letters) for x in range(y))

def send_msg():
     i = 0
     while  i < 10000:
         msg = random_char(20)
         i=i+1
         channel.basic_publish(exchange='',routing_key='qunide',body=msg )
         print("[x] sent %s'"  % msg)
  #       time.sleep(3)

while True:
    t=threading.Thread(target=send_msg())
    t.start()
 #send_msg()
 #    pool = multiprocessing.Pool(processes=10000)
 #    for i in range(10000)
  #    p = multiprocessing.Process(target=send_msg())
   #   p.start()
conn.close()
