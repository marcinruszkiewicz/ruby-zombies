require 'gosu'

class HelloWorldGame < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = 'Hello'
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

HelloWorldGame.new.show
