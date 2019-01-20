require "io/console"
class Cursor
  attr_accessor :row, :column, :current_dir
  def initialize(row, col)
    @row, @column = row, col
    @current_dir = :u
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def to_s
    case current_dir
    when :u
      return " ^ "
    when :d
      return " v "
    when :l
      return " < "
    when :r 
      return " > "
    end
  end 
end
