require 'hasu'
load 'droid.rb'
load 'bobba.rb'
class StarWars < Hasu::Window
  def initialize
    super 640, 320, false, 96
    self.caption = "Star Wars"
    @song = Gosu::Song.new self, "audio/starwars.mp3"
    @song.play
    @background = Gosu::Image.new self, "images/bg_senate.gif", true
    @bobba = Bobba.new self, 0, self.height
    @droid = nil
    @font = Gosu::Font.new(self, Gosu::default_font_name, 80)
    @gameover = false
  end

  def update
    close if button_down? Gosu::KbEscape
    add_droid if self.button_down? Gosu::KbN

    if @droid && (@bobba.x == @droid.x)
      @gameover = true
      @bobba.remove
    end



    if self.button_down? Gosu::KbRight
      @bobba.move :right
    end

    if self.button_down? Gosu::KbLeft
      @bobba.move :left
    end

    if self.button_down? Gosu::KbX
      @bobba.shoot @droid
    end

    @droid.update if @droid
    @bobba.update @droid
  end

  def draw
    @bobba.draw
    @droid.draw if @droid
    @background.draw 0,0,0,2.3,3
    @font.draw("Game Over", 120, 80, 1, 1,1, Gosu::Color.argb(0xffff0000)) if @gameover
  end

  def add_droid
    @droid = Droid.new self
  end
end
StarWars.run
