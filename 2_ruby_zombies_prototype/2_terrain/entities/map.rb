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

  def tile_walkable?(x, y)
    walkable = true
    @map.layers.each do |layer|
      next unless layer.properties['collision']
      walkable = false if layer.tile_at(x, y).to_i > 0
    end
    walkable
  end
end