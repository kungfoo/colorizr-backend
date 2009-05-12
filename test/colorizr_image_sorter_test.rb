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
    
    # TODO: Implement sorting of those images.
    scores = []
    images.each do |img|
      scores << img.amount_of_color([0,0,0])
    end
    
    ColorizrImageSorter.sort!(scores, images)
    id = 0
    images.each do |img|
      assert_equal(id, img.id)
      id += 1
    end
  end
  
  private
  # each entry will be unique, and as such identifiable via its primary key
  def shifted_images
    result = []
    vector = (0...ColorizrVector::VECTOR_LENGTH).to_a
    
    vector.each_with_index do |f, index|
      vector[index] = f.to_f
    end
    
    ColorizrVector::VECTOR_LENGTH.times do |id|
      colorizr_vector = ColorizrVector.new(vector.pack(ColorizrVector::FORMAT_STRING))
      result << ColorizrImage.new([id, colorizr_vector])
      vector << vector.shift
    end
    
    return result
  end
end