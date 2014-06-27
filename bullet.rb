class Bullet
  SPEED = 8
  attr_accessor :x
  def initialize window, shooter
    @x, @y, @window = shooter.x, shooter.y + shooter.height/2, window
    @image = Gosu::Image.new  @window, 'images/bullet.png', true
  end

  def update
    @x += SPEED unless @x > @window.width
  end

  def draw
    @image.draw @x, @y, 1, 0.7, 0.7
  end

  def hits? something
    @x > something.x
  end
end
