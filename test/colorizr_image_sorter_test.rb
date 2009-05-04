require "test/unit"

require "colorizr_vector"
require "colorizr_image_sorter"

class TestColorizrImageSorter < Test::Unit::TestCase
  
  def test_sorting_with_color
    assert_equal(1, 1)
  end
  
  def test_sorting_numbers_and_letters
    scores = [3.0,2.0,1.0]
    letters = ['c', 'b', 'a']
    
    returned = ColorizrImageSorter.sort!(scores, letters)
    assert_equal(letters, returned)
    assert_equal(['a','b','c'], returned)
    assert_equal([1.0,2.0,3.0], scores)
    # we should not have a copy, but a changed array
    assert_equal(letters.object_id, returned.object_id)
  end
  
  def test_sorting_numbers_and_objects
    scores = []
    objects = []
    
    100000.times do
      scores << rand()
      objects << Object.new
    end
    
    scores_control = Array.new(scores)
    
    ColorizrImageSorter.sort!(scores, objects)
    scores_control.sort!
    assert_equal(scores_control, scores)
  end
  
  def test_sorting_few_numbers
    scores = []
    objects = []
    
    1000.times do
      scores << rand()
      objects << Object.new
    end
    
    ColorizrImageSorter.sort!(scores, objects)
    
    min = 0
    scores.each do |value|
      assert_equal(true, value >= min)
      min = value
    end
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