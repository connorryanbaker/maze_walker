require_relative "grid"
require_relative "binarytree"
require_relative "aldous_broder"

class Game
  attr_reader :grid
  def initialize
    @grid = AldousBroder.on(Grid.new(15,15))
  end

  def ghosts
    grid.ghosts
  end 

  def cursor 
    grid.cursor
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
    grid.grid.flatten.all? {|e| e.visited}
  end 

  def render
    ghosts.each {|ghost| ghost.update_pos}
    system('clear')
    puts grid
    walk
  end

  def walk
    current_cell = self[cursor.row, cursor.column]
    current_cell.visited = true
    c = cursor.read_char
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

Game.new.play
