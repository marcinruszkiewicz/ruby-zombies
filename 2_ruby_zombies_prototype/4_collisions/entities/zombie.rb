class Zombie < GameObject
  def initialize(object_pool, world_x, world_y)
    super(object_pool)
    set_on_map(world_x, world_y)
    
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('zoimbie1_stand.png')
    @moving = @sprites.frame('zoimbie1_hold.png')

    @angle = 0
    @speed = 2
    @hp = 3

    @player = @object_pool.find_by_class('Player')
  end

  def update
    dist = Utils.distance(@world_x, @world_y, @player.world_x, @player.world_y)
    move_me = false

    if dist < 300
      @angle = Utils.get_angle(@world_x, @world_y, @player.world_x, @player.world_y)

      move_me = true
      new_x, new_y = @world_x, @world_y

      dx, dy = Utils.get_movement(@speed, @angle - 90)
      new_x -= dx
      new_y += dy
    end

    if move_me
      @sprite = @moving
      @world_x, @world_y = new_x, new_y if can_move_to?(new_x, new_y)
    else
      @sprite = @idle
    end
  end
end