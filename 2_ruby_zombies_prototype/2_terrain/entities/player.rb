class Player
  attr_accessor :x, :y, :angle, :screen_x, :screen_y

  def initialize(x, y, map)
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('manBlue_stand.png')

    @angle = 0
    @speed = 5

    @screen_x = $window.width / 2
    @screen_y = $window.height / 2
    @x = x
    @y = y
    @map = map
  end

  def update
    @angle = Utils.get_angle(@screen_x, @screen_y)
    new_x, new_y = @x, @y

    move_me = false
    # forward
    if $window.button_down?(Gosu::KbW)
      move_me = true
      dx, dy = Utils.get_movement(@speed, @angle - 90)
      new_x -= dx
      new_y += dy
    end

    # backward
    if $window.button_down?(Gosu::KbS)
      move_me = true
      dx, dy = Utils.get_movement(@speed, @angle + 90)
      new_x -= dx
      new_y += dy
    end

    # strafe left
    if $window.button_down?(Gosu::KbA)
      move_me = true
      dx, dy = Utils.get_movement(@speed, @angle)
      new_x += dx
      new_y -= dy
    end    

    # strafe right
    if $window.button_down?(Gosu::KbD)
      move_me = true
      dx, dy = Utils.get_movement(@speed, @angle)
      new_x -= dx
      new_y += dy
    end

    if move_me
      @x, @y = new_x, new_y if can_move_to?(new_x, new_y)
    end
  end

  def draw
    @idle.draw_rot(@screen_x, @screen_y, 1, @angle)
  end

  def viewport
    [(@x - $window.width/2), (@y - $window.height/2)]
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

  def can_move_to?(x, y)
    @map.within_map?(x, y) && @map.tile_walkable?(x, y)
  end  
end