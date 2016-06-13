class Zombie < GameObject
  def initialize(object_pool, world_x, world_y)
    super(object_pool)
    set_on_map(world_x, world_y)
    
    @sprites = Gosu::TexturePacker.load_json($window, Utils.media_path('sprites.json'), :precise)
    @idle = @sprites.frame('zoimbie1_stand.png')

    @angle = 0
    @speed = 2
    @hp = 3
  end
end