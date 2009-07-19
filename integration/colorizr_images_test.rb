require 'test/unit'
require 'colorizr_image'
require 'colorizr_image_sorter'

class ColorizImagesIntegrationTest < Test::Unit::TestCase
  
  def setup
    ColorizrImage.environment = :production
    @images = ColorizrImage.find_all
  end
  
  def test_production_db
    assert_equal(10401, @images.size())
  end
  
  def test_sorting_by_color
    color = [0,0,0]
    puts "loading scores"
    scores = @images.collect{ |img| img.amount_of_color(color) }
    assert_equal(10401, scores.size())
    
    puts "sorting...."
    ColorizrImageSorter.sort!(scores, @images)
    puts "done."
    
    dump_images(@images[0..20])
  end
  
  def dump_images(images)
    images.each_with_index do |img, i|
      data = img.image_data
      File.open("out/#{i}.jpg", "w") do |f|
        f.print(data)
      end
    end
  end
end
