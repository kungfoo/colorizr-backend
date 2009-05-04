class ColorizrVector
  COLOR_STEP = 63
  NUM_BINS  = 256 / COLOR_STEP + 1  
  VECTOR_LENGTH = NUM_BINS ** 3
  FORMAT_STRING = "G"*VECTOR_LENGTH # java saves stuff as network byte order.
  
  def initialize(binary_string)
    @vector = binary_string.unpack(FORMAT_STRING)
  end
  
  def each
    @vector.each { |i| yield i }
  end
end