class Player
  RUNNING = 1
  JUMPING = 2
  SLIDING = 3

  def initialize x,y
    @x, @y = x, y
    @state = RUNNING
    @running = Gosu::Image.load_tiles("media/Corgi - Running Forward.png", 48, 48, :tileable => true)
    @scales = [1,1.2,1.4,1.6,1.8,1.6,1.4,1.2,1]
    @scale = 1
  end

  def draw
    @player_image.draw_rot @x, @y, 0, @rot, 0.5, 0.5, @scale, @scale
  end

  def update
    @player_image = cur_image
  end

  def cur_image
    case @state
      when RUNNING
        @running[Gosu::milliseconds / 175 % 3]
      when JUMPING
        @jumpstate += 1 if ((Gosu::milliseconds / 175 % 3) == 0)
        @scale = @scales[@jumpstate]
        @state = RUNNING if @jumpstate == 8
        @running[Gosu::milliseconds / 175 % 3]
    end
  end

  def move_forward
    @rot = 0
  end

  def move_right
    @rot = 15
    @x += 5
  end

  def move_left
    @rot = -15
    @x -= 5
  end

  def jump
    return if @state == JUMPING
    @jumpstate = 0
    @state = JUMPING
  end
end

