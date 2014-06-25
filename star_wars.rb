require 'hasu'
load 'droid.rb'
load 'bobba.rb'
class StarWars < Hasu::Window
  def initialize
    super 640, 480, false, 96
    self.caption = "Star Wars"
    @sample = Gosu::Sample.new self, "audio/gun.mp3"
    @song = Gosu::Song.new self, "audio/starwars.mp3"
    @song.play
    @background = Gosu::Image.new self, "images/bg_senate.gif", true
    @bobba = Bobba.new self, 0, self.height - 42
    @droid = nil
  end

  def button_down id
    close if id == Gosu::KbEscape
    if id == Gosu::KbX
      @bobba.shoot
      @sample.play
      @bobba.shooting = true
    end

    if id == Gosu::KbN
      @droid = add_droid
    end

    def add_droid
      droid = Droid.new self, self.width, self.height-51
    end

  end

  def update
    @bobba.update
    if @droid
      @droid.update
      if @bobba.someone_in_front?(@droid) && @bobba.shooting
        @droid.kill if @droid
        @bobba.shooting = false
      else
        @bobba.shooting = false
      end
    end
  end

  def draw
    @bobba.draw
    @droid.draw if !@droid.nil?
    @background.draw 0,0,0,2.3,3
  end
end
StarWars.run
