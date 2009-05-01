require "colorizr_config"
require "colorizr_histogram"
require "rubygems"
require "sqlite3"

class ColorizrImage
  attr_reader :id, :image_data, :colorizr_histogram
  
  @@environment = :production
  @@config = ColorizrConfig.new
  @@db = nil

  def initialize(row_data)
    @id, @image_data, @colorizr_histogram = row_data
  end

  def self.findAll
    connect_to_database
    result = []
    
    @@db.execute("select * from mood") do |row|
      result << ColorizrImage.new(convert_row(row))
    end
    return result
  end

  def self.environment=(env)
    @@environment = env
  end

  def self.environment
    @@environment
  end

  private
  def self.convert_row(row)
    histogram = ColorizrHistogram.new(row[2])
    return [row[0], row[1], histogram]
  end
  
  
  def self.connect_to_database
    unless @@db
      case @@environment
      when :production
        @@db = SQLite3::Database.new(@@config.production_db)
      when :test
        @@db = SQLite3::Database.new(@@config.test_db)
      else
      end
      puts "connected to database!"
      @@db.type_translation = true
    end
  end
end