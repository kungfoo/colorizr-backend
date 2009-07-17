class ColorizrVector
  COLOR_STEP = 63
  NUM_BINS  = 256 / COLOR_STEP + 1
  NUM_BINS_SQ = NUM_BINS * NUM_BINS
  VECTOR_LENGTH = NUM_BINS ** 3
  FORMAT_STRING = "G"*VECTOR_LENGTH # java saves stuff as network byte order.
  
  # takes a binary string and converts it to a ColorizrVector.
  def initialize(binary_string)
    @vector = binary_string.unpack(FORMAT_STRING)
  end
  
  # Takes an array of color values [r,g,b] and returns the amount
  # of interpolated color that the image that produced this vector contained.
  def amount_of_color(color)
    @vector[map_to_bin(color[0], color[1], color[2])]
  end
  
  def each
    @vector.each { |i| yield i }
  end
  
  # provides a mapping between bin number and color ranges.
  def self.map_bin_to_color(bin)
    # TODO: implement this method.
  end
  
  private
  def map_to_bin(r,g,b)
    NUM_BINS_SQ * (r/COLOR_STEP) + NUM_BINS * (g/COLOR_STEP) + b/COLOR_STEP
  end
end
