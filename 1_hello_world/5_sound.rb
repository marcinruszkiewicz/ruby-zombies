require 'gosu'

class HelloWorldGame < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = 'Hello'

    @sound = Gosu::Sample.new self, "beep.wav"

    @message = Gosu::Image.from_text(
      self, 'Hello, World!', Gosu.default_font_name, 42)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @sound.play
  end

  def update
    @x = self.width/2 - @message.width/2 + Math.sin(Time.now.to_f) * 150
    @y = self.height/2 - @message.height/2 + Math.cos(Time.now.to_f) * 200
  end

  def draw
    @message.draw(@x, @y, 0)
  end
end

HelloWorldGame.new.show
