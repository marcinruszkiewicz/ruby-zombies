class PlayState < GameState

  def initialize
    @player = Player.new(300, 100)
    @map = Map.new
    @player.set_map(@map)
  end

  def update
    @player.update
    $window.caption = "RubyZombies. [FPS: #{Gosu.fps}.]"
  end

  def draw
    off_x = @player.screen_x - $window.width/2
    off_y = @player.screen_y - $window.height/2
    $window.translate(off_x, off_y) do
      @map.draw(@player.viewport)
      @player.draw
    end

    @player.draw_crosshair 
  end

  def button_down(id)
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end

end