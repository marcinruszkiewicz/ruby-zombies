class Map
  def initialize
    @map = Gosu::Tiled.load_json($window, Utils.media_path('map_1.json'))
    @x = @y = 0
  end

  def draw(viewport)
    x0, y0 = viewport.map(&:to_i)
    @map.draw(x0, y0)
  end

  def out_of_bounds?(x, y)
    return true if x < 0 || y < 0
    return true if x > @map.width || y > @map.height

    false
  end
end