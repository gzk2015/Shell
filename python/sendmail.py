#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from email import encoders
from email.header import Header
from email.mime.text import MIMEText
from email.utils import parseaddr, formataddr
import os
import smtplib

def _format_addr(s):
    name, addr = parseaddr(s)
    return formataddr((Header(name, 'utf-8').encode(), addr))

from_addr = ''
password = ''
to_addr = ''
smtp_server = 'smtp.exmail.qq.com'

with open('C:\Users\Administrator\Desktop\module.txt', 'r') as f:
    c =  f.read()

msg = MIMEText( c, 'plain', 'utf-8')
msg['From'] = _format_addr('Sadmin <%s>' % from_addr)
msg['To'] = _format_addr('Sadmin <%s>' % to_addr)
msg['Subject'] = Header('短信接口扫描状态', 'utf-8').encode()

server = smtplib.SMTP(smtp_server, 25)
#server.set_debuglevel(1)
server.login(from_addr, password)
server.sendmail(from_addr, [to_addr], msg.as_string())
server.quit()
