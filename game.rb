require_relative "grid"
require_relative "binarytree"
require_relative "aldous_broder"

class Game
  def initialize
    @grid = AldousBroder.on(Grid.new(15,15))
  end

  def play
    @grid.play
  end
end

Game.new.play
