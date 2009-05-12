require 'colorizr_image_sorter'

class SortBenchmark
  N = 1000000
  
  def initialize
    scores = scores_array(N)
    letters = character_array(N)
    
    @s1 = Array.new(scores)
    @s2 = Array.new(scores)
    @l1 = Array.new(letters)
    @l2 = Array.new(letters)
  end
  
  def run
    sort_c
    # sort_array
  end
  
  def sort_c
    @l1 = ColorizrImageSorter.sort!(@s1, @l1)
  end
  
  def sort_array
    
  end
  
  def scores_array(n)
    result = []
    n.times { result << rand() }
    result
  end
  
  def character_array(n)
    result = []
    n.times { result << Object.new }
    result
  end
end

SortBenchmark.new.run