class PlayState < GameState

  def initialize
    @player = Player.new
  end

  def update
    @player.update
    $window.caption = "RubyZombies. [FPS: #{Gosu.fps}.]"
  end

  def draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end

end