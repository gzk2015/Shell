#!/usr/bin/python
import  pycurl
from StringIO import StringIO

def sendmail(msg):
    


def check_web(web_url):
    temp = StringIO()
    c = pycurl.Curl()
    c.setopt(c.URL, web_url)
    c.setopt(c.WRITEFUNCTION, temp.write)
    c.perform()
    speed = c.getinfo(pycurl.SPEED_DOWNLOAD)/1024/1024
    status = c.getinfo(pycurl.HTTP_CODE)
    time = c.getinfo(pycurl.TOTAL_TIME)
    print "website: %s ; access_status is : %s ; download speed is: %s M ; complete time is : %s" %( web_url, status, speed, time)
    c.close()


def main():
    urlfile = './web.txt'
    with open(urlfile) as f:
        urls = f.readlines()
        for i in urls:
            if i:
                check_web(i.strip())

if __name__ == '__main__':
	main()
