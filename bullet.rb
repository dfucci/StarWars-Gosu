class Bullet
  SPEED = 8
  def initialize window, shooter
    @x, @y, @window = shooter.x, shooter.y + shooter.height/2, window
    @image = Gosu::Image.new  @window, 'images/bullet.png', true
  end

  def hit_target?
    false
  end

  def update
    @x += SPEED unless hit_target?
  end

  def draw
    @image.draw @x, @y, 1, 0.7, 0.7
  end
end
