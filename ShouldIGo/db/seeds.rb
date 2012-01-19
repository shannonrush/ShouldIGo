# Elements

elements = ["TMAX","TMIN","PRCP","ACSC","AWND"]
elements.each {|e| Element.find_or_create_by_code e}

# Stations

Station.delete_all
open("#{Rails.root}/db/data/ghcnd-stations.txt") do |stations|
  stations.read.each_line do |station|
    array = station.split(' ')
    Station.create!(:code => array[0], :lat => array[1], :lng => array[2])
  end
end

# Records

Record.delete_all
Dir.foreach("#{Rails.root}/db/data/records") do |file|
  unless File.directory?(file)
    station_code = file.split(".")[0]
    station = Station.find_by_code(station_code)
    if station.present?
      open("#{Rails.root}/db/data/records/#{file}") do |records|
        records.read.each_line do |record|
          element = Element.find_by_code(record[(17..20)])
          if element.present?
            year = record[(11..14)]
            month = record[(15..16)]
            char = 21
            day = 1
            while char < 266 do
              value = record[(char..char+4)].to_i == -9999 ? nil : record[(char..char+4)].to_i
              Record.create!(:station_id => station.id, :year => year, :month => month, :day => day, :element_id => element.id, :value => value) 
              day += 1
              char += 8
            end
          end
        end
      end
    end
  end
end

