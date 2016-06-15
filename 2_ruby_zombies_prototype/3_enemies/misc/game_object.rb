class GameObject
  attr_accessor :x, :y, :angle, :screen_x, :screen_y, :object_pool, :sprite

  def initialize(object_pool, x, y)
    @object_pool = object_pool
    @object_pool.objects << self

    @x = x
    @y = y
  end

  def update; end

  def draw(viewport)
    x0, y0 = viewport.map(&:to_i)
    @sprite.draw_rot(@x - x0, @y - y0, 1, @angle)
  end

  def can_move_to?(x, y)
    @object_pool.map.within_map?(x, y) && @object_pool.map.tile_walkable?(x, y)
  end
end