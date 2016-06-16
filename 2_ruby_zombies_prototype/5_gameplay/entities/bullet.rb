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
end