class Map
  def initialize
    @map = Gosu::Tiled.load_json($window, Utils.media_path('map_1.json'))
    @x = @y = 0
  end

  def draw(viewport)
    x0, y0 = viewport.map(&:to_i)
    @map.draw(x0, y0)
  end

  def within_map?(x, y)
    (0..@map.width).include?(x) && (0..@map.height).include?(y)
  end

  def width
    @map.width
  end

  def height
    @map.height
  end
end