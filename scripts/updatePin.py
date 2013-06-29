import os


def main():
  
  pins = []
  with open('PINS.csv', 'r') as f:
    lines = f.readlines()[0].split('\r')
    
    for line in lines:
      pin = line.split(',')[0]
      pins.append(pin)
    
    pins.pop(0)
  
  f1 = open('getDeeds.coffee', 'rb')
  script = f1.read()
  f1.close()
  
  for pin in pins:
    
    print pin
    numbers = pin.split('-')
    tmp = script.replace('AA', numbers[0])
    tmp = tmp.replace('BB', numbers[1])
    tmp = tmp.replace('CC', numbers[2])
    tmp = tmp.replace('DD', numbers[3])
    tmp = tmp.replace('EE', numbers[4])
    
    f3 = open('getDeedsTmp.coffee', 'wb')
    f3.write(tmp)
    f3.close()
    
    os.system('casperjs getDeedsTmp.coffee > %s.html' % pin)
    os.system('rm getDeedsTmp.coffee')


if __name__ == '__main__':
  main()