class Bobba
  attr_reader :x, :y, :direction, :shoots
  attr_accessor :shooting
  SPEED = 6
  def initialize window, x, y
    @x, @window, @direction, @shooting, @shoots = x, window, direction, false, 3
    @width = 32
    @height = 41
    @frame = 0
    @image = Gosu::Image.load_tiles @window, "images/bobba.png", @width, @height, true
    @direction = :right
    @y = y - @height - 1 # 1px padding 
  end

  def can_shoot?
    @shoots>0
  end


  def someone_in_front? other
    @x < other.x && @direction == :right || @x > other.x && @direction == :left
  end

  def shoot
    @shoots -= 1 if can_shoot?
  end

  def next_tile
    @frame+=1
  end

  def update
    if @window.button_down? Gosu::KbRight
      @direction = :right
      @x += SPEED
      @x = 0 if self.x > @window.width
      next_tile
    end
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @x -= SPEED
      @x = @window.width if self.x < 0
      next_tile
    end
  end

  def draw
    f = @frame % @image.size
    tile = @image[f]
    if @direction == :right
      tile.draw @x, @y, 1
    else
      tile.draw @x + tile.width, @y, 1, -1
    end
  end
end
