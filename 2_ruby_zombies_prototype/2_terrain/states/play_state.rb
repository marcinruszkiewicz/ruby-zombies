class PlayState < GameState

  def initialize
    @map = Map.new
    @player = Player.new(300, 100, @map)
  end

  def update
    @player.update
    $window.caption = "RubyZombies. [FPS: #{Gosu.fps}.]"
  end

  def draw
    @map.draw(@player.viewport)
    @player.draw
    @player.draw_crosshair 
  end

  def button_down(id)
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end

end