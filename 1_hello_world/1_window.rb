require 'gosu'

class HelloWorldGame < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = 'Hello'
  end
end

HelloWorldGame.new.show
