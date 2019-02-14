require_relative 'binarytree'
require_relative 'cell'
require_relative 'cursor'
require_relative 'ghost'
require 'colorize'

class Grid
  attr_reader :rows, :columns, :cursor, :ghosts, :grid
  def initialize(rows, columns)
    @rows, @columns = rows, columns
    @grid = prepare_grid
    configure_cells
    @cursor = Cursor.new(0,0)
    @ghosts = [Ghost.new(rows - 1, 0, self), Ghost.new(0, columns - 1, self), Ghost.new(rows - 1, columns - 1, self)]
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(row, column)
      end
    end
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column

      cell.n = self[row - 1, col]
      cell.s = self[row + 1, col]
      cell.e = self[row, col + 1]
      cell.w = self[row, col - 1]
    end
  end

  def [](row, col)
    return nil unless row.between?(0, rows - 1)
    return nil unless col.between?(0, columns - 1)
    @grid[row][col]
  end

  def random_cell
    row = rand(@rows)
    column = rand(@grid[row].count)

    self[row, column]
  end

  def size
    @rows * @columns
  end

  def each_row
    @grid.each do |row|
      yield row
    end
  end

  def each_cell
    each_row do |row|
      row.each do |cell|
        yield cell if cell
      end
    end
  end

  def to_s
    output = "+" + "---+" * columns + "\n"
    each_row do |row|
      top = "|"
      bottom = "+"
      row.each do |cell|
        cell = Cell.new(-1,-1) unless cell
        body = "   "
        if ghosts.any? {|g| [g.row, g.column] == [cell.row, cell.column]}
          body = " G ".colorize(:blue)
        elsif [cursor.row, cursor.column] == [cell.row, cell.column] 
          body = cursor.to_s.colorize(:red)
        elsif cell.visited
          body = "   "
        else 
          body = " o "
        end 
        east_boundary = (cell.linked?(cell.e) ? " " : "|")
        top << body << east_boundary

        south_boundary = (cell.linked?(cell.s) ? "   " : "---")
        corner = "+"
        bottom << south_boundary << corner
      end
      output << top << "\n"
      output << bottom << "\n"
    end
    output
  end

  def play
    system('clear')
    puts "welcome to the maze!!!"
    sleep 2
    until game_over?
      render
    end 
  end

  def game_over?
    lost? || won?
  end 

  def lost?
    ghosts.any? {|ghost| [ghost.row, ghost.column] == [cursor.row, cursor.column]}
  end 

  def won?
    grid.flatten.all? {|e| e.visited}
  end 

  def render
    ghosts.each {|ghost| ghost.update_pos}
    system('clear')
    puts self
    walk
  end

  def walk
    current_cell = self[cursor.row, cursor.column]
    current_cell.visited = true
    c = @cursor.read_char
    case c
      when "\e[A"
        if current_cell.linked?(self[cursor.row - 1, cursor.column])
          cursor.current_dir = :u
          cursor.row -= 1
        end
      when "\e[B"
        if current_cell.linked?(self[cursor.row + 1, cursor.column])
          cursor.current_dir = :d
          cursor.row += 1
        end
      when "\e[C"
        if current_cell.linked?(self[cursor.row, cursor.column + 1])
          cursor.current_dir = :r
          cursor.column += 1
        end
      when "\e[D"
        if current_cell.linked?(self[cursor.row, cursor.column - 1])
          cursor.current_dir = :l
          cursor.column -= 1
        end
    end
  end
end

