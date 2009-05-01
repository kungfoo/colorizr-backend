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
  
  def test_findAll
    # make sure we're in the right setting...
    assert_equal(:test, ColorizrImage.environment)
    images = ColorizrImage.findAll
    assert_equal(2, images.size)
  end
  
  def test_histogram_values_larger_than_zero
    images = ColorizrImage.findAll
    images.each do |img|
      img.colorizr_histogram.each do |f|
        assert_equal(true, f >= 0)
      end
    end
  end
end