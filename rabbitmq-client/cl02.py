import  pika
import random
import string

conn = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = conn.channel()

channel.queue_declare(queue='hello')

def random_char(y):
    return ''.join(random.choice(string.ascii_letters) for x in range(y))


i = 0
while  i < 20:
    msg = random_char(i)
    i=i+1
    channel.basic_publish(exchange='',routing_key='hello',body=msg )
    print("[x] sent %s'"  % msg)

conn.close()