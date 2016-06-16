class Player < GameObject
  SHOOT_DELAY = 500

  def initialize(object_pool, x, y)
    super(object_pool, x, y)

    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('manBlue_stand.png')
    @moving = @sprites.frame('manBlue_reload.png')

    @angle = 0
    @speed = 5
    @hp = 5

    @screen_x = $window.width / 2
    @screen_y = $window.height / 2
  end

  def update
    super
    
    @angle = Utils.get_angle(@screen_x, @screen_y)

    move_me = false
    new_x, new_y = @x, @y

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

    # shoot
    if Utils.button_down?(Gosu::MsLeft)
      fire_bullet
    end

    if move_me
      @sprite = @moving
      @x, @y = new_x, new_y if can_move_to?(new_x, new_y)
    else
      @sprite = @idle
    end
  end

  def death
    GameState.switch(MenuState.instance)    
  end

  def draw(viewport)
    @sprite.draw_rot(@screen_x, @screen_y, 1, @angle)
    draw_bounding_box(viewport)
  end

  def fire_bullet
    if Gosu.milliseconds - (@last_shot || 0) > SHOOT_DELAY
      @last_shot = Gosu.milliseconds
      bullet = Bullet.new(@object_pool, @x, @y)
      bullet.angle = @angle
    end
  end
end