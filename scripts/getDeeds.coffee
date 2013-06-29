# 20-16-105-018-0000

setPIN = ->
  document.querySelectorAll('#SearchFormEx1_PINTextBox0')[0].setAttribute('value', 'AA')
  document.querySelectorAll('#SearchFormEx1_PINTextBox1')[0].setAttribute('value', 'BB')
  document.querySelectorAll('#SearchFormEx1_PINTextBox2')[0].setAttribute('value', 'CC')
  document.querySelectorAll('#SearchFormEx1_PINTextBox3')[0].setAttribute('value', 'DD')
  document.querySelectorAll('#SearchFormEx1_PINTextBox4')[0].setAttribute('value', 'EE')

links = []
casper = require('casper').create()

casper.start "http://12.218.239.81/i2/default.aspx"

casper.then ->
  @evaluate setPIN
  @click("#SearchFormEx1_btnSearch")

casper.then ->
  @echo 'HERE'
  @wait 1000, ->
    @echo @getHTML("#DocList1_WidgetContainer")

casper.run ->
  console.log 'done'