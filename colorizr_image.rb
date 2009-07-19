require 'rubygems'
require "configatron"
require "colorizr_vector"
require "rubygems"
require "sqlite3"

class ColorizrImage
  attr_reader :id, :colorizr_vector
  attr_writer :score
  
  configatron.configure_from_yaml("config/config.yml")
  
  @@environment = :production
  @@db = nil
  @@image_data_db = nil

  def initialize(row_data)
    @id, @colorizr_vector = row_data
  end
  
  # returns the amount of color that is saved in this images vector for the given [r,g,b]-color
  def amount_of_color(color)
    colorizr_vector.amount_of_color(color)
  end
  
  def image_data
    sql = "select image_data from colorizr_image_data where id=#{@id}"
    @@image_data_db.execute(sql) do |row|
      return row[0]
    end
  end
  
  
  def self.find_all
    connect_to_database
    result = []
    
    @@db.execute("select * from colorizr_vector") do |row|
      result << ColorizrImage.new(convert_row(row))
    end
    return result
  end
   
  def self.environment=(env)
    @@environment = env
    reconnect
  end
  
  def self.environment
    @@environment
  end


  private
  def self.convert_row(row)
    vector = ColorizrVector.new(row[1])
    return [row[0], vector]
  end

  def self.connect_to_database
    unless @@db
      reconnect
    end
  end

  def self.reconnect
    case @@environment
    when :production
      @@db = SQLite3::Database.new(configatron.database.production.vector)
      @@image_data_db = SQLite3::Database.new(configatron.database.production.image_data)
    when :test
      @@db = SQLite3::Database.new(configatron.database.test.vector)
      @@image_data_db = SQLite3::Database.new(configatron.database.test.image_data)
    else
    end
    puts "connected to database! env:#{@@environment}"
    @@db.type_translation = true
  end
end
