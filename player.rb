class Player
  attr_accessor :x, :y

  FINISHED = 0
  RUNNING = 1
  JUMPING = 2
  SLIDING = 3
  MAX_JUMP_TIME = 500
  MAX_SIZE = 1.8
  MIN_SIZE = 1
  TURN_ANGLE = 15
  TURN_SPEED = 5
  MAX_RUN_SPEED = 3

  def initialize x,y
    @x, @y = x, y
    @state = RUNNING
    @jump_sound = Gosu::Sample.new("media/sounds/jump.wav")
    @running = Gosu::Image.load_tiles("media/Corgi - Running Forward.png", 48, 48, :tileable => true)
    @delta_scale = 0
    @scale = 1
    @jumpstate = Gosu::milliseconds
    @rot = 0
    @player_image = cur_image
  end

  def draw
    @player_image.draw_rot @x, @y, 0, @rot, 0.5, 0.5, @scale, @scale
  end

  def update
    @scale += @delta_scale
    @scale = MIN_SIZE if @scale < MIN_SIZE
    @scale = MAX_SIZE if @scale > MAX_SIZE
    @player_image = cur_image
    @delta_scale = -0.1
  end

  def cur_image
    case @state
      when FINISHED
        @running[0]
      when RUNNING
        running_frame
      when JUMPING
        @state = RUNNING if end_of_jump?
        running_frame
    end
  end

  def move_forward
    @y -= MAX_RUN_SPEED
    if @y < 100
      @y = 100
      @rot = @rot + 4 % 360
      @state = FINISHED
    else 
      @rot = 0
    end
  end

  def move_right
    @rot = TURN_ANGLE
    @x += TURN_SPEED
  end

  def move_left
    @rot = -TURN_ANGLE
    @x -= TURN_SPEED
  end

  def jump
    return if must_fall?
    @delta_scale = 0.1
    @jumpstate = Gosu::milliseconds + MAX_JUMP_TIME if @jumpstate < Gosu::milliseconds
    @jump_sound.play if ( @state != JUMPING && @state != FINISHED )
    @state = JUMPING
  end

  private

  def running_frame
    @running[Gosu::milliseconds / 175 % 3]
  end

  def must_fall?
    @state == JUMPING && Gosu::milliseconds > @jumpstate
  end

  def end_of_jump?
    must_fall? && @scale == MIN_SIZE
  end
end

