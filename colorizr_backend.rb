require "colorizr_config"

class ColorizrBackend
  
  def initialize
    @config = ColorizrConfig.new
    connect_database
  end
  
  
  private
  def connect_database
    
  end
end