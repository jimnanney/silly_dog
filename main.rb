require "gosu"
require_relative "player"

class SillyDog < Gosu::Window
  def initialize
    super 800, 600, false
    self.caption = "Silly Dog"
    @player = Player.new 400, 400
  end

  def update
    @player.move_forward
    @player.move_left if Gosu.button_down? Gosu::KbLeft
    @player.move_right if Gosu.button_down? Gosu::KbRight
    @player.jump if Gosu.button_down? Gosu::KbUp
    @player.jump if Gosu.button_down? Gosu::KbSpace
    @player.update
  end

  def draw
    @player.draw
  end

end

game = SillyDog.new
game.show

