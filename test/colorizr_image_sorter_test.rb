require "test/unit"

require "colorizr_image_sorter"

class TestColorizrImageSorter < Test::Unit::TestCase
  
  def test_sorting
    assert_equal(1, 1)
  end
  
  def test_shifted_colorizr_images
    images = shifted_images
    images.each do |img|
      assert_equal(125, img.colorizr_vector.size)
    end
  end
  
  private
  # each entry will be unique, and as such identifiable via its primary key
  def shifted_images
    result = []
    vector = (0...125).to_a
    
    125.times do |id|
      result << ColorizrImage.new([id, vector])
      vector << vector.shift
    end
    return result
  end
end