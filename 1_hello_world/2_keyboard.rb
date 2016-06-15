require 'gosu'

class HelloWorldGame < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = 'Hello'

    @sound = Gosu::Sample.new self, "beep.wav"
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @sound.play
  end
end

HelloWorldGame.new.show
