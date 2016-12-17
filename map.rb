class Map
  attr_reader :width, :height

  def initialize
    @tileset = Gosu::Image.load_tiles("media/Tiles.png", 48, 48, :tileable => true)
    @height = 100
    @width = 17
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        0
      end
    end
  end

  def update
  end

  def draw
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        @tileset[tile].draw(x * 48, y * 48, 0)
      end
    end
  end
end
