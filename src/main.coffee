
map = null
markerLayer = null

intervals = ['2005', '2006', '2007', '2008', '2009', '2010q1', '2010q2', '2010q3', '2010q4', '2011q1', '2011q2', '2011q3', '2011q4', '2012q1', '2012q2', '2012q3', '2012q4', '2013q1', '2013q2', '2013q3', '2013q4']


createVisualization = (d1, d2) ->
  markerLayer = new L.LayerGroup()
  
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
    L.marker([lat, lon]).addTo(markerLayer)
      .bindPopup(s)
  
  markerLayer.addTo(map)
  
  $("input[type='range']").on('change', (e) ->
    interval = intervals[e.target.value]
    
    # Clear the layer
    markerLayer.clearLayers()
    
    console.log interval
    pins = d1[interval]
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
      L.marker([lat, lon]).addTo(markerLayer)
        .bindPopup(s)
  )
  

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
  
  $.getJSON('../data/intervals.json')
    .done( (data) ->
      dfd1.resolve(data)
    )
  
  $.getJSON('../data/deeds.json')
    .done( (data) ->
      dfd2.resolve(data)
    )
  
  $.getJSON('../data/englewood.geojson')
    .done( (data) ->
      L.geoJson(data).addTo(map)
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