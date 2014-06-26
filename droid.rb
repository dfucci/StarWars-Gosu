class Droid
  attr_accessor :x, :y
  SPEED = 2
  TOTAL_FRAME_HIT = 8
  def initialize window, x, y
    @x, @y, @window = x, y, window
    @height = 50
    @width = 39
    @height_hit = 65
    @width_hit = 50
    @image = Gosu::Image.load_tiles @window, "images/droid.png", @width, @height, true
    @image_hit = Gosu::Image.load_tiles @window, "images/droid_hit.png", @width_hit, @height_hit, true
    @frame = 0
    @frame_hit = 0
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
      @x -= SPEED
      @frame += 1
    else
      @frame_hit += 1 unless @frame_hit == TOTAL_FRAME_HIT
    end
  end

  def draw
    if !is_dead?
      f = @frame % @image.size
      tile = @image[f]
      tile.draw @x, @y, 1
    else
      f = @frame_hit% @image_hit.size
      tile = @image_hit[f]
      tile.draw @x, @y, 1
    end
  end
end
