class Droid
  attr_accessor :x, :y
  def initialize window, x, y
    @x, @y, @window =x,y, window
    @height = 50
    @width = 39
    @image = Gosu::Image.load_tiles @window, "images/droid.png", @width, @height, true
    @frame = 0
    @dead = false
  end
  def kill
    @dead = true
  end

  def is_dead?
     @dead
  end
  def update
    if !is_dead?
      @x -= 2
      @frame += 1
    end
  end

  def draw
    if !is_dead?
      f = @frame % @image.size
      tile = @image[f]
      tile.draw @x, @y, 1
    end
  end
end
