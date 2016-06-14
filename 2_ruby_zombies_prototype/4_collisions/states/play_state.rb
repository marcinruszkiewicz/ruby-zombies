class PlayState < GameState

  def initialize
    @map = Map.new
    @object_pool = ObjectPool.new(@map)

    @player = Player.new(@object_pool, 300, 100)
    spawn_zombies 10

    @interface = Interface.new(@player)
  end

  def update
    @object_pool.update
    @interface.update
  end

  def draw
    @map.draw(@interface.viewport)
    @object_pool.draw(@interface.viewport)

    @interface.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end

  def spawn_zombies(number)
    number.times do 
      x = rand(0..@map.width)
      y = rand(0..@map.height)

      redo unless @map.tile_walkable?(x, y)

      Zombie.new(@object_pool, x, y)
    end
  end

end