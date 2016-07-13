class Interface
  def initialize(target)
    @target = target
  end

  def update
    $window.caption = "RubyZombies!!. [FPS: #{Gosu.fps}.]"
  end

  def draw
    draw_crosshair
  end

  def viewport
    [(@target.x - @target.screen_x), (@target.y - @target.screen_y)]
  end

  def draw_crosshair
    x = $window.mouse_x
    y = $window.mouse_y
    $window.draw_line(
      x - 10, y, Gosu::Color::RED,
      x + 10, y, Gosu::Color::RED, 100)
    $window.draw_line(
      x, y - 10, Gosu::Color::RED,
      x, y + 10, Gosu::Color::RED, 100)
  end  
end