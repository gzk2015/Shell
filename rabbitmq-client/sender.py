import sys
import pika
from random import Random

credent=pika.PlainCredentials("admin","111111")
conn_params = pika.ConnectionParameters("10.125.145.87" , credentials=credent, virtual_host="/")
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()
channel.exchange_declare(exchange="test-ex",
                         type="direct",
                         passive=False,
                         durable=False,
                         auto_delete=False )



def random_str(randomlength=1000):
    str = ''
    chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
    length = len(chars) - 1
    random = Random()
    for i in range(randomlength):
        str+=chars[random.randint(0, length)]
    return str



for i in range(1,20):

	msg = random_str(20)
 #   msg=str(i)
	msg_props = pika.BasicProperties()
	msg_props.content_type="text/plain"
	channel.basic_publish(body=msg,
                      exchange="test-ex",
                      properties=msg_props,
                      routing_key="test-ex")
	print( "sent %s  " %msg)

	
conn.close()
