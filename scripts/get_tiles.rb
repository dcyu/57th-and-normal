require 'sqlite3'

def get_tiles
  root = File.join('..', 'tiles')
  
  db = SQLite3::Database.new File.join('mapping-data', 'TheArea.mbtiles')
  
  tiles = db.execute "SELECT zoom_level, tile_column, tile_row, tile_data FROM tiles;"
  tiles.each_with_index do |tile, index|
    zoom, column, row, data = tile
    
    # # Convert from TMS to XYZ
    # column = 2 ** zoom - 1
    # row = column - row
    
    puts File.join("#{root}", "#{zoom}", "#{column}", "#{row}.png")
    
    zdir = File.join(root, zoom.to_s)
    Dir.mkdir(zdir) unless File.directory?(zdir)
    
    ydir = File.join(root, zoom.to_s, column.to_s)
    Dir.mkdir(ydir) unless File.directory?(ydir)
    
    png_path = File.join(ydir, "#{row}.png")
    f = File.new(png_path, 'wb')
    f.write(data)
    f.close
    
  end
  
end

get_tiles()