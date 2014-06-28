class Droid
  attr_accessor :x, :y
  attr_reader :direction
  SPEED = 2
  TOTAL_FRAME_HIT = 8
  def initialize window
    @window = window
    @height = 50
    @width = 39
    @height_hit = 65
    @width_hit = 50
    @image = Gosu::Image.load_tiles @window, "images/droid.png",
       @width, @height, true
    @image_hit = Gosu::Image.load_tiles @window, "images/droid_hit.png",
        @width_hit, @height_hit, true
    @frame = 0
    @frame_hit = 0
    @dead = false
    @direction = directions[rand(2)]
    @x = nil
    @y = @window.height - @height - 1
    if direction == :right
      @x = 0
    else
      @x = @window.width
    end
  end

  def update
    if !is_dead?
      @x -= SPEED if @direction == :left
      @x += SPEED if @direction == :right
      @frame += 1
    else
      @frame_hit += 1 unless @frame_hit == TOTAL_FRAME_HIT
    end
  end

  def draw
    if !is_dead?
      f = @frame % @image.size
      tile = @image[f]
      tile.draw(@x, @y, 1) if @direction == :left
      tile.draw(@x, @y, 1, -1) if @direction == :right
    else
      f = @frame_hit% @image_hit.size
      tile = @image_hit[f]
      if direction == :left
        tile.draw @x, @y, 1
      else
        tile.draw @x, @y, 1, -1
      end
    end
  end

  def kill
    @dead = true
  end

  def is_dead?
    @dead
  end

  private
  def directions
    %i(left right)
  end
end
