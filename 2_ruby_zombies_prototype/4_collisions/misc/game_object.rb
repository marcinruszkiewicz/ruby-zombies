class GameObject
  attr_accessor :hp, :x, :y, :angle, :screen_x, :screen_y, :object_pool, :sprite

  def initialize(object_pool)
    @object_pool = object_pool
    @object_pool.objects << self

    @hp = 1
  end

  def set_on_map(x, y)
    @x = x
    @y = y
  end

  def update; end

  def draw(viewport)
    x0, y0 = viewport.map(&:to_i)
    @sprite.draw_rot(@x - x0, @y - y0, 1, @angle)
    draw_bounding_box(viewport)
  end

  def can_move_to?(x, y)
    @object_pool.map.within_map?(x, y) && @object_pool.map.tile_walkable?(x, y)
  end

  def box
    @w = @sprite.width / 2
    @h = @sprite.height / 2

    Utils.rotate(@angle, @x, @y,
      @x - @w, @y - @h,
      @x + @w, @y - @h,
      @x + @w, @y + @h,
      @x - @w, @y + @h
    )
  end

  def draw_bounding_box(viewport)
    x0, y0 = viewport.map(&:to_i)
    color = Gosu::Color.argb(0x99_ffff00)

    box.each_slice(2) do |x, y|
      $window.draw_triangle(
        x - x0 - 3, y - y0 - 3, color,
        x - x0,     y - y0,     color,
        x - x0 + 3, y - y0 - 3, color,
        100
      )
    end
  end
end