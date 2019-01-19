require_relative "grid"
require_relative "cell"
class BinaryTree
  def self.on(grid)
    grid.each_cell do |cell|
      neighbors = []
      neighbors << cell.n if cell.n
      neighbors << cell.e if cell.e

      neighbor = neighbors.sample
      cell.link(neighbor) if neighbor
    end
    grid
  end
end
