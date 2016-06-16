class GameObject
  attr_accessor :hp, :x, :y, :angle, :screen_x, :screen_y, :object_pool, :sprite, :removable, :disabled_collision_types

  def initialize(object_pool, x, y)
    @object_pool = object_pool
    @object_pool.objects << self

    @hp = 1
    @x = x
    @y = y
    @in_collision = false
    @removable = false
    @disabled_collision_types = []
  end

  def update
    death if @hp < 1
  end

  def death
    @removable = true
  end

  def draw(viewport)
    x0, y0 = viewport.map(&:to_i)
    @sprite.draw_rot(@x - x0, @y - y0, 1, @angle)
    draw_bounding_box(viewport)
  end

  def collides_with_terrain?(x, y)
    walkable = @object_pool.map.within_map?(x, y) && @object_pool.map.tile_walkable?(x, y)
    !walkable
  end

  def can_move_to?(x, y)
    terrain = collides_with_terrain?(x, y)
    !terrain && !collides_with_nearby?(x, y)
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

  def collision_with(object)
    @in_collision = true
  end

  def collides_with_nearby?(x, y)
    collides = false
    old_x, old_y = @x, @y
    @x = x
    @y = y

    @object_pool.find_nearby(self, 50).each do |obj|
      next if @disabled_collision_types.include? obj.class.name

      if collides_with_poly?(obj.box)
        new_dist = Utils.distance(@x, @y, x, y)
        old_dist = Utils.distance(@x, @y, old_x, old_y)

        if new_dist < old_dist
          collision_with(obj)
          obj.collision_with(self)
          collides = true
        end
      end
    end

    collides
  ensure
    @x = old_x
    @y = old_y
  end

  def collides_with_poly?(poly)
    if poly
      if poly.size == 2
        px, py = poly
        return Utils.point_in_poly(px, py, *box)
      end

      poly.each_slice(2) do |x, y|
        return true if Utils.point_in_poly(x, y, *box)
      end

      box.each_slice(2) do |x, y|
        return true if Utils.point_in_poly(x, y, *poly)
      end
    end
    
    false
  end
end