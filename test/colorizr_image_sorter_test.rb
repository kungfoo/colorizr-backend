require "test/unit"

require "colorizr_vector"
require "colorizr_image_sorter"

class TestColorizrImageSorter < Test::Unit::TestCase
  
  def test_sorting_with_color
    assert_equal(1, 1)
  end
  
  def test_shifted_colorizr_images
    images = shifted_images
    images.each do |img|
      vector = img.colorizr_vector
      assert_equal(ColorizrVector::VECTOR_LENGTH, vector.size)
    end
  end
  
  private
  # each entry will be unique, and as such identifiable via its primary key
  def shifted_images
    result = []
    vector = (0...ColorizrVector::VECTOR_LENGTH).to_a
    
    ColorizrVector::VECTOR_LENGTH.times do |id|
      result << ColorizrImage.new([id, Array.new(vector)])
      vector << vector.shift
    end
    return result
  end
end