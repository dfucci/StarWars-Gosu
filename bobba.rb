load 'bullet.rb'
class Bobba
  attr_reader :x, :y, :direction, :shoots, :height, :bullet
  attr_accessor :shooting
  SPEED = 6
  def initialize window, x, y
    @height, @x, @window, @direction, @shooting, @shoots = height, x, window, direction, false, 3
    @width = 32
    @height = 41
    @frame = 0
    @sample = Gosu::Sample.new @window, "audio/gun.mp3"
    @image = Gosu::Image.load_tiles @window, "images/bobba.png", @width, @height, true
    @direction = :right
    @y = y - @height - 1 # 1px padding
    @shooting = false
    @bullet = nil
    @shooting_direction = :right
  end

  def update(droid=nil)
    @bullet.update if @shooting && @bullet
    self.kill droid if droid
  end

  def draw
    @bullet.draw if @bullet
    f = @frame % @image.size
    tile = @image[f]
    if @direction == :right
      tile.draw @x, @y, 1
    else
      tile.draw @x + tile.width, @y, 1, -1
    end
  end

  def can_shoot?
    @shoots>0
  end


  def facing? other
    @x < other.x && @direction == :right || @x > other.x && @direction == :left
  end

  def next_tile
    @frame+=1
  end

  def move direction
    @direction = direction
    @x += SPEED if @direction == :right
    @x -= SPEED if @direction == :left
    @x = 0 if self.x > @window.width
    @x = @window.width if self.x < 0
    next_tile
  end

  def shoot droid
    @shooting_direction = @direction
    @sample.play
      @shooting = true
      @bullet = Bullet.new @window, self
  end

  def kill droid
    if @bullet && @bullet.hits?(droid, @shooting_direction)
      droid.kill
      droid = nil
      @bullet = nil
    end
  end
end
