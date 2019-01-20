class Ghost
  attr_accessor :row, :column
  attr_reader :grid

  def initialize(row, column, grid)
    @row, @column = row, column
    @grid = grid
  end

  def update_pos
    neighbor = grid[row, column].neighbors.select {|cell| grid[row,column].linked?(cell)}.sample
    other_ghosts = grid.ghosts.reject {|g| g == self}
    unless other_ghosts.any? {|g| [g.row, g.column] == [neighbor.row, neighbor.column]}
      @row, @column = neighbor.row, neighbor.column
    end
  end
end


