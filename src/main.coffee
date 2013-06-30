
map = null

layers = {}
icons = {}


intervals = ['2005', '2006', '2007', '2008', '2009', '2010q1', '2010q2', '2010q3', '2010q4', '2011q1', '2011q2', '2011q3', '2011q4', '2012q1', '2012q2', '2012q3', '2012q4', '2013q1', '2013q2', '2013q3', '2013q4']


NS = [
  'NORFOLK SOUTHERN RAILWAY CO'
  'NORFOLK & SOUTHERN RAILROAD CORP'
  'NORFOLK & SOUTHERN RAILWAY ILLINOIS CONSTRUCTION C'
  'NORFOLK SOUTHER RAILWAY CO'
  'NORFOLK SOUTHERN CORP'
  'NORFOLK SOUTHERN RAILRAY CO'
  'NORFOLK SOUTHERN RAILROAD'
  'NORFOLK SOUTHERN RAILROAD CORP'
  'NORFOLK SOUTHERN RAILWAY'
  'NORFOLK SOUTHERN RAILWAY COMPANY'
  'NORFOLK SOUTHERN RAILWAY COMPANY'
  'NORFOLK SOUTHERN RAILWAY INC'
  'NORFOLK SOUTHTERN RAILWAY CO'
  'NORTHFOLK SOUTHERN RAILWAY CO'
]


createLeafletIcons = ->
  icons.blue = L.icon({
    # iconUrl: '../js/leaflet/images/button_blue.png'
    iconUrl: '../js/leaflet/images/NonNSProperties.png'
    iconSize: [12, 12]
    iconAnchor: [6, 6]
  })
  
  icons.red = L.icon({
    # iconUrl: '../js/leaflet/images/button_red.png'
    iconUrl: '../js/leaflet/images/NSProperties.png'
    iconSize: [12, 12]
    iconAnchor: [6, 6]
  })

createVisualization = (d1, d2) ->
  
  createLeafletIcons()
  
  # Create marker layers and add to map
  layers.blue = new L.LayerGroup()
  layers.red = new L.LayerGroup()
  
  layers.blue.addTo(map)
  layers.red.addTo(map)
  
  # Define callback for when slider is moved
  $("input[type='range']").on('change', (e) ->
    console.log e
    
    # Look up interval based on index
    interval = intervals[e.target.value]
    
    # Update text on page to show interval
    $('.interval p').text(interval)
    
    # Clear only the blue layer
    layers.blue.clearLayers()
    
    # Get list of pins and interval
    data = d1[interval]
    
    for obj in data
      pin = obj.pin
      grantee = obj['first-grantee']
      
      # Determine if the property owned by NS
      category = if grantee in NS then 'red' else 'blue'
      icon = icons[category]
      layer = layers[category]
      
      datum = d2[pin]
      
      lat = datum.lat
      lon = datum.lon
      deeds = datum.deeds
      
      # Format deeds
      s = ""
      for deed in deeds
        for key, value of deed
          s += "#{pin}, #{key}, #{value}"
        s += "<br>"
      L.marker([lat, lon], icon: icon).addTo(layer)
        .bindPopup(s)
  )
  

DOMReady = ->
  
  # Initialize map
  map = L.map('map', {minZoom: 15, maxZoom: 18}).setView([41.787148, -87.637666], 15)
  
  # L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  #     attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  # }).addTo(map)
  
  L.tileLayer('../tiles/{z}/{x}/{y}.png').addTo(map)
  
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
  
  # $.getJSON('../data/englewood.geojson')
  $.getJSON('../data/the-area.geojson')
    .done( (data) ->
      style =
        color: '#000'
        weight: 2
        opacity: 1.0
        fillOpacity: 0.2
      L.geoJson(data, {
        style: style
        onEachFeature: (feature, layer) -> 
          console.log feature, layer
          layer.on('click', (d) ->
            
            @setStyle({color: 'red'})
            # setTimeout ( ->
            #   d.layer.options.color = 'red'
            #   # console.log Object.keys(d)
            # ), 1000
          )
      }).addTo(map)
    )
  

window.addEventListener('DOMContentLoaded', DOMReady, false)