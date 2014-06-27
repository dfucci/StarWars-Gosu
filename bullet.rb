class Bullet
  SPEED = 8
  attr_accessor :x, :direction
  def initialize window, shooter
    @x, @y, @direction, @window = shooter.x, shooter.y + shooter.height/2, shooter.direction,window
    @image = Gosu::Image.new  @window, 'images/bullet.png', true
  end

  def update
    if @direction == :right
      @x += SPEED unless @x > @window.width
    else
      @x -= SPEED unless @x < 0
    end
  end

  def draw
    @image.draw @x, @y, 1, 0.7, 0.7 if @direction == :right
    @image.draw_rot(@x, @y, 1, 180, 1, 1, 0.7, 0.7) if @direction == :left

  end

  def hits? something, facing
    (@x > something.x && facing == :right || @x < something.x && facing == :left) && !something.is_dead?
  end
end
