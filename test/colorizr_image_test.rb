require "test/unit"
require "colorizr_image"

class TestColorizrImage < Test::Unit::TestCase
  def test_default_environment
    assert_equal(:test, ColorizrImage.environment)
    ColorizrImage.environment = :production
    assert_equal(:production, ColorizrImage.environment)
  end
  
  def setup
    ColorizrImage.environment = :test
  end
    
  def test_find_all
    # make sure we're in the right setting...
    assert_equal(:test, ColorizrImage.environment)
    images = ColorizrImage.find_all
    assert_equal(2, images.size)
  end
  
  def test_histogram_values_larger_than_zero
    images = ColorizrImage.find_all
    
    images.each do |img|
      img.colorizr_histogram.each do |f|
        assert_equal(true, f >= 0)
      end
    end
  end
  
  def test_switching_database
    assert_equal(:test, ColorizrImage.environment)
    images = ColorizrImage.find_all
    assert_equal(2, images.size)
    
    ColorizrImage.environment = :production
    # commented out while actively developing. slows test.
    # images = ColorizrImage.find_all
    # assert_equal(21480, images.size)
    
    # and back again
    ColorizrImage.environment = :test
    images = ColorizrImage.find_all
    assert_equal(2, images.size)
  end
end
