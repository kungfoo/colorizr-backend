require "test/unit"

require "colorizr_vector"

class TestColorizrVector < Test::Unit::TestCase
  def test_map_to_bin
    @vector = ColorizrVector.new("ffffffff")

    # the two boundaries are known
    assert_equal(0, map_value(0,0,0))
    assert_equal(124, map_value(255,255,255))
    assert_equal(62, map_value(127,127,127))
  end

  def test_from_increasing_binary
    binary = ordered_vector.pack("G"*ColorizrVector::VECTOR_LENGTH)
    # eight bytes each
    assert_equal(ColorizrVector::VECTOR_LENGTH*8, binary.size)

    vector = ColorizrVector.new(binary)
    assert_equal(0, vector.amount_of_color([0,0,0]))
    assert_equal(124, vector.amount_of_color([255,255,255]))

    i = 0
    (0..255).step(ColorizrVector::COLOR_STEP) do |r|
      (0..255).step(ColorizrVector::COLOR_STEP) do |g|
        (0..255).step(ColorizrVector::COLOR_STEP) do |b|
          assert_equal(i, vector.amount_of_color([r,g,b]))
          i += 1
        end
      end
    end
  end

  private
  def map_value(r,g,b)
    @vector.send("map_to_bin", r,g,b)
  end

  def ordered_vector
    vector = (0...ColorizrVector::VECTOR_LENGTH).to_a
    assert_equal(125, vector.size)
    return vector
  end
end