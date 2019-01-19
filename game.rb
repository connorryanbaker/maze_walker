require_relative "grid"
require_relative "binarytree"

class Game
  def initialize
    @grid = BinaryTree.on(Grid.new(15,15))
  end

  def play
    @grid.play
  end
end

Game.new.play
