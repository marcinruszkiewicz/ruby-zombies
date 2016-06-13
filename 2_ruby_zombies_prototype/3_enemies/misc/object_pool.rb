class ObjectPool
  attr_accessor :objects, :map

  def initialize(map)
    @objects = []
    @map = map
  end

  def update
    @objects.map(&:update)
  end

  def draw(viewport)
    @objects.each { |obj| obj.draw(viewport) }
  end
end