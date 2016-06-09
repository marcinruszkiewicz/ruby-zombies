class Player
  attr_accessor :x, :y, :angle

  def initialize
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('manBlue_stand.png')
    
    @x = $window.width / 2
    @y = $window.height / 2
    @angle = 0
    @speed = 5
  end

  def update
    @angle = Utils.get_angle(@x, @y)
    new_x, new_y = @x, @y

    # forward
    if $window.button_down?(Gosu::KbW)
      new_x -= @speed * Math.sin(Utils.transform_degrees_to_radians(@angle - 90))
      new_y += @speed * Math.cos(Utils.transform_degrees_to_radians(@angle - 90))
    end

    # backward
    if $window.button_down?(Gosu::KbS)
      new_x -= @speed * Math.sin(Utils.transform_degrees_to_radians(@angle + 90))
      new_y += @speed * Math.cos(Utils.transform_degrees_to_radians(@angle + 90))
    end

    # strafe left
    if $window.button_down?(Gosu::KbA)
      new_x += @speed * Math.sin(Utils.transform_degrees_to_radians(@angle))
      new_y -= @speed * Math.cos(Utils.transform_degrees_to_radians(@angle))
    end    

    # strafe right
    if $window.button_down?(Gosu::KbD)
      new_x -= @speed * Math.sin(Utils.transform_degrees_to_radians(@angle))
      new_y += @speed * Math.cos(Utils.transform_degrees_to_radians(@angle))
    end

    @x, @y = new_x, new_y
  end

  def draw
    @idle.draw_rot(@x, @y, 1, @angle)
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