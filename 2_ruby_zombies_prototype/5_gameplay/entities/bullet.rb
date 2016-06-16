class Bullet < GameObject
  def initialize(object_pool, x, y)
    super(object_pool, x, y)

    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @sprite = @sprites.frame('tile_187.png')

    @angle = 0
    @speed = 5
  end

  def box
    [@x, @y]
  end

  def update
    new_x, new_y = @x, @y
    
    dx, dy = Utils.get_movement(@speed, @angle - 90)
    new_x -= dx
    new_y += dy

    @x, @y = new_x, new_y if can_move_to?(new_x, new_y)
  end

  def collision_with(object)
    if object.class.name == 'Zombie'
      @in_collision = true
      @removable = true
      object.hp -= 1
    end
  end
end