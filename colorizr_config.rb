require "yaml"

class ColorizrConfig
  CONFIG_FILE = "config/config.yml"
  
  def initialize
    @config = YAML.load_file(CONFIG_FILE)
  end
  
  def method_missing(method, *args)
    @config[method.to_s]
  end
end