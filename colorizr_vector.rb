class ColorizrVector
  COLOR_STEP = 63
  NUM_BINS  = 256 / COLOR_STEP + 1
  NUM_BINS_SQ = NUM_BINS * NUM_BINS
  VECTOR_LENGTH = NUM_BINS ** 3
  FORMAT_STRING = "G"*VECTOR_LENGTH # java saves stuff as network byte order.
  
  def initialize(binary_string)
    @vector = binary_string.unpack(FORMAT_STRING)
  end
  
  def amount_of_color(color)
    @vector[map_to_bin(color[0], color[1], color[2])]
  end
  
  def each
    @vector.each { |i| yield i }
  end
  
  private
  def map_to_bin(r,g,b)
    NUM_BINS_SQ * (r/COLOR_STEP) + NUM_BINS * (g/COLOR_STEP) + b/COLOR_STEP
  end
end
