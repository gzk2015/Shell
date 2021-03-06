#!/usr/bin/env python
#coding=utf8

import pika
import sys

credent=pika.PlainCredentials("gtadmin","123456")
conn_params = pika.ConnectionParameters("10.125.145.81" , credentials=credent, virtual_host="/")
conn = pika.BlockingConnection(conn_params)

channel = conn.channel()

#channel.exchange_declare(exchange="", type="direct", passive=True,

#channel.exchange_declare( queue="hello", 
#                        durable=False,

#                         auto_delete=False)

channel.queue_declare(queue="qunide" ,durable=True,)
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
                        queue="qunide",
                        no_ack=True,
                        consumer_tag="test-consumer")


print (' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()


conn.close()

