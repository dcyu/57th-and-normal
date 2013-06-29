
map = null

createVisualization = (d1, d2) ->
  console.log 'createVisualization', d1, d2
  
  # Start at 2005
  pins = d1['2011q4']
  for pin in pins
    datum = d2[pin]
    
    lat = datum.lat
    lon = datum.lon
    
    # Format deeds
    deeds = datum.deeds
    s = ""
    for deed in deeds
      for key, value of deed
        s += "#{pin}, #{key}, #{value}"
      s += "<br>"
    L.marker([lat, lon]).addTo(map)
      .bindPopup(s)
  

DOMReady = ->
  
  # Initialize map
  map = L.map('map').setView([41.7922, -87.6378], 15)
  
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map)
  
  # Two deferred objects for each JSON
  dfd1 = new $.Deferred()
  dfd2 = new $.Deferred()
  
  $.when(dfd1, dfd2).done(createVisualization)
  
  $.getJSON('../scripts/data/intervals.json')
    .done( (data) ->
      dfd1.resolve(data)
    )
  
  $.getJSON('../scripts/data/deeds.json')
    .done( (data) ->
      dfd2.resolve(data)
    )
  
  # $.getJSON('../scripts/data/deeds.json')
  #   .done( (data) ->
  #     pins = Object.keys(data)
  #     
  #     for pin in pins
  #       datum = data[pin]
  #       
  #       # Get coordinates
  #       lat = datum.lat
  #       lon = datum.lon
  #       
  #       # Format deeds
  #       deeds = datum.deeds
  #       s = ""
  #       for deed in deeds
  #         for key, value of deed
  #           s += "#{pin}, #{key}, #{value}"
  #         s += "<br>"
  #       L.marker([lat, lon]).addTo(map)
  #         .bindPopup(s)
  #   )
  

window.addEventListener('DOMContentLoaded', DOMReady, false)