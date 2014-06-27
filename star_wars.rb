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
  end

  def update
    close if button_down? Gosu::KbEscape
    add_droid if self.button_down? Gosu::KbN

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
  end

  def add_droid
    @droid = Droid.new self, self.width, self.height - 51
  end
end
StarWars.run
