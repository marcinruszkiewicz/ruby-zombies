class ObjectPool
  attr_accessor :objects, :map

  def initialize(map)
    @objects = []
    @map = map
  end

  def update
    @objects.map(&:update)
    @objects.reject! { |obj| obj.removable == true }
  end

  def draw(viewport)
    @objects.each { |obj| obj.draw(viewport) }
  end

  def find_by_class(klass)
    @objects.detect { |o| o.class.name == klass }
  end

  def find_nearby(object, max_distance)
    @objects.select do |obj|
      distance = Utils.distance(obj.x, obj.y, object.x, object.y)

      obj != object && distance < max_distance
    end
  end
end