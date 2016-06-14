class Utils
  def self.media_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', file)
  end

  def self.get_angle(x1, y1, x2 = nil, y2 = nil)
    x2 ||= $window.mouse_x
    y2 ||= $window.mouse_y
    
    atan = Math.atan2(x1 - x2, y1 - y2)
    ((-atan * 180 / Math::PI) - 90)
  end

  def self.transform_degrees_to_radians(angle_in_degrees)
    (Math::PI * 2 * angle_in_degrees) / 360
  end

  def self.distance(x1, y1, x2, y2)
    Math.hypot(x2-x1,y2-y1)
  end
end