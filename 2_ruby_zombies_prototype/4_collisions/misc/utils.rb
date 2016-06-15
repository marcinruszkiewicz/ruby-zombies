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
    Math.hypot(x2 - x1, y2 - y1)
  end

  def self.get_movement(speed, angle)
    dx = speed * Math.sin(Utils.transform_degrees_to_radians(angle))
    dy = speed * Math.cos(Utils.transform_degrees_to_radians(angle))

    [dx, dy]
  end

  def self.rotate(angle, pivot_x, pivot_y, *points)
    result = []
    angle = angle * Math::PI / 180.0
    points.each_slice(2) do |x, y|
      r_x = Math.cos(angle) * (pivot_x - x) - Math.sin(angle) * (pivot_y - y) + pivot_x
      r_y = Math.sin(angle) * (pivot_x - x) + Math.cos(angle) * (pivot_y - y) + pivot_y
      result << r_x
      result << r_y
    end
    result
  end

  # http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
  def self.point_in_poly(testx, testy, *poly)
    nvert = poly.size / 2 # Number of vertices in poly
    vertx = []
    verty = []
    poly.each_slice(2) do |x, y|
      vertx << x
      verty << y
    end
    inside = false
    j = nvert - 1
    (0..nvert - 1).each do |i|
      if (((verty[i] > testy) != (verty[j] > testy)) &&
         (testx < (vertx[j] - vertx[i]) * (testy - verty[i]) /
         (verty[j] - verty[i]) + vertx[i]))
        inside = !inside
      end
      j = i
    end
    inside
  end  
end