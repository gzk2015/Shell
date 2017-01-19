#!/usr/bin/env python
#coding=utf8

import pika
import sys

credent=pika.PlainCredentials("admin","111111")
conn_params = pika.ConnectionParameters("10.69.213.105" , credentials=credent, virtual_host="/test")
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()

#channel.exchange_declare(exchange="", type="direct", passive=True,

#channel.exchange_declare( queue="hello", 
#                        durable=False,

#                         auto_delete=False)

channel.queue_declare(queue="hello" ,durable=False,)
#channel.queue_bind(queue="test-queue",exchange="test-ex",routing_key="test-ex")

#
# def msg_consumer(channel,method,header,body):
#     channel.basic_ack(delivery_tag=method.delivery_tag)
#     if body == "quit":
#         channel.basic_cancel(consumer_tag="hello-consumer")
#         channel.stop_consuming()
#
#     return

def callback( ch , method , properties , body):
    print("***Received %r" %body) 



channel.basic_consume( callback,
                        queue="hello",
                        no_ack=True,
                        consumer_tag="test-consumer")


print (' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()


conn.close()

