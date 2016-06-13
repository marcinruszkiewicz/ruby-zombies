class GameObject
  attr_accessor :hp, :x, :y, :angle, :world_x, :world_y, :object_pool

  def initialize(object_pool)
    @object_pool = object_pool
    @object_pool.objects << self

    @hp = 1
  end

  def set_on_map(world_x, world_y)
    @world_x = world_x
    @world_y = world_y
  end

  def update; end

  def draw(viewport)
    x0, y0 = viewport.map(&:to_i)
    @idle.draw_rot(@world_x - x0, @world_y - y0, 1, @angle)
  end

  def can_move_to?(x, y)
    @object_pool.map.within_map?(x, y)
  end
end