# 20-16-105-018-0000

getLinks = ->
  links = document.querySelectorAll "h3.r a"
  Array::map.call links, (e) -> e.getAttribute "href"

setPIN = ->
  document.querySelectorAll('#SearchFormEx1_PINTextBox0')[0].setAttribute('value', '20')
  document.querySelectorAll('#SearchFormEx1_PINTextBox1')[0].setAttribute('value', '16')
  document.querySelectorAll('#SearchFormEx1_PINTextBox2')[0].setAttribute('value', '105')
  document.querySelectorAll('#SearchFormEx1_PINTextBox3')[0].setAttribute('value', '018')
  document.querySelectorAll('#SearchFormEx1_PINTextBox4')[0].setAttribute('value', '0000')

links = []
casper = require('casper').create()

casper.start "http://12.218.239.81/i2/default.aspx"

casper.then ->
  # @echo @getHTML("#SearchFormEx1_PINTextBoxRow")
  @evaluate setPIN
  @click("#SearchFormEx1_btnSearch")

casper.then ->
  @echo 'HERE'
  @wait 1000, ->
    @echo @getHTML("#DocList1_WidgetContainer")

casper.run ->
  console.log 'done'

# casper.start "http://google.fr/", ->
#   # search for 'casperjs' from google form
#   @fill "form[action='/search']", q: "casperjs", true
# 
# casper.then ->
#   # aggregate results for the 'casperjs' search
#   links = @evaluate getLinks
#   # search for 'phantomjs' from google form
#   @fill "form[action='/search']", q: "phantomjs", true
# 
# casper.then ->
#   # concat results for the 'phantomjs' search
#   links = links.concat @evaluate(getLinks)
# 
# casper.run ->
#   # display results
#   @echo links.length + " links found:"
#   @echo(" - " + links.join("\n - ")).exit()