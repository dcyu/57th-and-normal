

DOMReady = ->
  
  # Initialize map
  map = L.map('map').setView([41.7922, -87.6378], 16)
  
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map)
  
  $.getJSON('../scripts/deeds.json')
    .done( (data) ->
      pins = Object.keys(data)
      
      for pin in pins
        datum = data[pin]
        
        # Get coordinates
        lat = datum.lat
        lon = datum.lon
        
        # Format deeds
        deeds = datum.deeds
        s = ""
        for deed in deeds
          for key, value of deed
            s += "#{key}, #{value}"
          s += "<br>"
        L.marker([lat, lon]).addTo(map)
          .bindPopup(s)
      
      
    )
  

window.addEventListener('DOMContentLoaded', DOMReady, false)