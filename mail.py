#!/bin/python
#for zabbix
#-*- coding:utf-8 -*-

import time
import sys
import smtplib  
from email.Header import Header
from email import encoders
from email.mime.text import MIMEText
from email.MIMEMultipart import MIMEMultipart
from email.utils import parseaddr, formataddr

#define mailbox used for send mails
mail_host="smtp.qiye.163.com"
mail_from="guanzhongkai@yingmoo.com"
mail_user="guanzhongkai@yingmoo.com"
mail_pass="BJYM2016yingmoo"


#for test
#mail_to="443108869@qq.com"
#subject="zabbix"
#body="zabbix  test 194's nginx is down!please check it!"

#define function
def send_mail(mailto,subject,body):
    msg=MIMEMultipart()
    msg['subject']=subject
    msg['from']=mail_from
    msg['to']=mail_to
    msg['date']=time.ctime()
    txt=MIMEText(body,'plain','utf-8')
    msg.attach(txt)


    s=smtplib.SMTP(mail_host,25)
    s.set_debuglevel(0)
    #s.starttls()
    s.login(mail_user,mail_pass)
    s.sendmail(mail_from,mail_to,msg.as_string())
    s.close()



	

#main function
if __name__=='__main__':
#get three argv from scripts 

	mail_to=sys.argv[1]
	subject=sys.argv[2]
	body=sys.argv[3]
	send_mail(mail_to,subject,body)	
