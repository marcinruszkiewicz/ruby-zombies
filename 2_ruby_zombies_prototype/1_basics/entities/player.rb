class Player
  attr_accessor :x, :y, :angle

  def initialize
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('manBlue_stand.png')
    @x = $window.width / 2
    @y = $window.height / 2
  end

  def update
    new_x, new_y = @x, @y

    new_x -= 5 if $window.button_down?(Gosu::KbA)
    new_x += 5 if $window.button_down?(Gosu::KbD)
    new_y -= 5 if $window.button_down?(Gosu::KbW)
    new_y += 5 if $window.button_down?(Gosu::KbS)

    @x, @y = new_x, new_y
  end

  def draw
    @idle.draw_rot(@x, @y, 0, 0)
  end
end