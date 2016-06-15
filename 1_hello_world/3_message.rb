require 'gosu'

class HelloWorldGame < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = 'Hello'

    @message = Gosu::Image.from_text(
      self, 'Hello, World!', Gosu.default_font_name, 42)

    @sound = Gosu::Sample.new self, "beep.wav"
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @sound.play
  end

  def draw
    @message.draw(
      self.width/2 - @message.width/2,
      self.height/2 - @message.height/2,
      0
    )
  end
end

HelloWorldGame.new.show
