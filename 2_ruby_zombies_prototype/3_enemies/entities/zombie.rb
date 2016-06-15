class Zombie < GameObject
  def initialize(object_pool, x, y)
    super(object_pool, x, y)
    
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('zoimbie1_stand.png')
    @moving = @sprites.frame('zoimbie1_hold.png')

    @angle = 0
    @speed = 1

    @player = @object_pool.find_by_class('Player')
  end

  def update
    dist = Utils.distance(@x, @y, @player.x, @player.y)
    move_me = false

    if dist < 300
      @angle = Utils.get_angle(@x, @y, @player.x, @player.y)

      move_me = true
      new_x, new_y = @x, @y

      new_x -= @speed * Math.sin(Utils.transform_degrees_to_radians(@angle - 90))
      new_y += @speed * Math.cos(Utils.transform_degrees_to_radians(@angle - 90))
    end

    if move_me
      @sprite = @moving
      @x, @y = new_x, new_y if can_move_to?(new_x, new_y)
    else
      @sprite = @idle
    end
  end
end