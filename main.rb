require "gosu"
require_relative "player"
require_relative "map"

class SillyDog < Gosu::Window
  HEIGHT = 600
  WIDTH = 800

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Silly Dog"
    @player = Player.new 400, 4700
    @camera_x = @camera_y = 0
    @map = Map.new
  end

  def update
    @player.move_forward
    @player.move_left if Gosu.button_down? Gosu::KbLeft
    @player.move_right if Gosu.button_down? Gosu::KbRight
    @player.jump if Gosu.button_down? Gosu::KbUp
    @player.jump if Gosu.button_down? Gosu::KbSpace
    @camera_y = [[@player.y - HEIGHT / 2, 0].max, @map.height * 48 - HEIGHT].min
    @camera_x = [[@player.x - WIDTH / 2, 0].max, @map.width * 48 - WIDTH].min
    @player.update
    @map.update
  end

  def draw
    Gosu::translate(-@camera_x, -@camera_y) do
      @map.draw
      @player.draw
    end
  end

end

game = SillyDog.new
game.show

