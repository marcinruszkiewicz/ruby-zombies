class Utils
  def self.media_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', file)
  end

  def self.get_angle
    atan = Math.atan2(
      $window.width/2 - $window.mouse_x,
      $window.height/2 - $window.mouse_y
    )
    ((-atan * 180 / Math::PI) - 90)
  end

  def self.transform_degrees_to_radians(angle_in_degrees)
    (Math::PI * 2 * angle_in_degrees) / 360
  end   
end