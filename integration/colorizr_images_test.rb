require 'test/unit'
require 'colorizr_image'
require 'colorizr_image_sorter'

class ColorizImagesIntegrationTest < Test::Unit::TestCase
  
  def setup
    ColorizrImage.environment = :production
    @images = ColorizrImage.find_all
  end
  
  def test_production_db
    assert_equal(10401, @images.size)
  end
  
  def test_sorting_by_color
    color = [255,255,128]
    puts "loading scores"
    scores = @images.collect{ |img| 1.0 - img.amount_of_color(color) }
    assert_equal(10401, scores.size)
    
    puts "sorting...."
    ColorizrImageSorter.sort!(scores, @images)
    puts "done."
    
    # check all others have a smaller score
    first_score = 1.0 - @images.first.amount_of_color(color)
    @images[1..@images.size].each do |img|
      assert(first_score <= 1.0 - img.amount_of_color(color), "#{first_score} <= #{1.0-img.amount_of_color(color)}")
    end
    
    @images[0..20].each do |img|
      puts "image id: #{img.id}"
    end
    
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
