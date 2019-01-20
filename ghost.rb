require 'byebug'
class Ghost
  attr_accessor :row, :column
  attr_reader :grid

  def initialize(row, column, grid)
    @row, @column = row, column
    @grid = grid
  end

  def update_pos
    neighbor = grid[row, column].neighbors.select {|cell| grid[row,column].linked?(cell)}.sample
    @row, @column = neighbor.row, neighbor.column
  end
end


