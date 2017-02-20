import sys
import pika
from random import Random

credent=pika.PlainCredentials("admin","111111")
conn_params = pika.ConnectionParameters("10.69.213.105" , credentials=credent,)
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()
# channel.exchange_declare(exchange="test-ex",
#                          type="direct",
#                          passive=False,
#                          durable=False,
#                          auto_delete=False )

channel.queue_declare(queue='hello',durable=True)

def random_str(randomlength=1000):
    str = ''
    chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
    length = len(chars) - 1
    random = Random()
    for i in range(randomlength):
        str+=chars[random.randint(0, length)]
    return str



for i in range(1,20):

	msg = random_str(200)
 #   msg=str(i)
	msg_props = pika.BasicProperties()
	msg_props.content_type="text/plain"
	channel.basic_publish(body=msg,
                      exchange="",
                      # properties=msg_props,
                      routing_key="hello")
	print( "send %s  " %msg)

	
conn.close()
