
import os

def main():
  
  f = open('getDeeds.coffee', 'rb')
  data = f.read()
  
  data = data.replace('AA', '20')
  data = data.replace('BB', '16')
  data = data.replace('CC', '105')
  data = data.replace('DD', '018')
  data = data.replace('EE', '0000')
  
  f2 = open('getDeedsTmp.coffee', 'wb')
  f2.write(data)
  f2.close()
  
  os.system('casperjs getDeedsTmp.coffee')
  os.system('killall phantomjs')
  os.system('rm getDeedsTmp.coffee')
  

if __name__ == '__main__':
  main()