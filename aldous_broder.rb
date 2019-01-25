require_relative 'grid'
class AldousBroder
  def self.on(grid)
    cell = grid.random_cell
    unvisited = grid.size - 1

    while unvisited > 0
      n = cell.neighbors.sample

      if n.links.empty?
        cell.link(n)
        unvisited -= 1
      end

      cell = n
    end
    grid
  end
end

puts AldousBroder.on(Grid.new(5,5))
