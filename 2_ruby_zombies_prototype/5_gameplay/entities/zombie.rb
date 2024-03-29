class Zombie < GameObject
  BITE_DELAY = 1000

  def initialize(object_pool, x, y)
    super(object_pool, x, y)
    
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('zoimbie1_stand.png')
    @moving = @sprites.frame('zoimbie1_hold.png')

    @angle = 0
    @speed = 2
    @hp = 2

    @player = @object_pool.find_by_class('Player')
  end

  def collision_with(object)
    if object == @player
      if Gosu.milliseconds - (@last_shot || 0) > BITE_DELAY
        @last_shot = Gosu.milliseconds
        @player.hp -= 1
      end
    end
  end

  def update
    super

    dist = Utils.distance(@x, @y, @player.x, @player.y)
    move_me = false

    if dist < 300
      @angle = Utils.get_angle(@x, @y, @player.x, @player.y)

      move_me = true
      new_x, new_y = @x, @y

      dx, dy = Utils.get_movement(@speed, @angle - 90)
      new_x -= dx
      new_y += dy
    end

    if move_me
      @sprite = @moving
      @x, @y = new_x, new_y if can_move_to?(new_x, new_y)
    else
      @in_collision = false
      @sprite = @idle
    end
  end
end