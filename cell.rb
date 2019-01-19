class Cell
  attr_reader :row, :column
  attr_accessor :n, :s, :e, :w, :visited

  def initialize(row, column)
    @visited = false
    @row, @column = row, column
    @links = {}
  end

  def link(cell, bidi=true)
    @links[cell] = true
    cell.link(self, false) if bidi
    self
  end

  def linked?(cell)
    @links.has_key?(cell)
  end

  def unlink(cell, bidi=true)
    @links.delete(cell)
    cell.unlink(self, false) if bidi
    self
  end

  def links
    @links.keys
  end

  def neighbors
    list = []
    list << n if n
    list << s if s
    list << e if e
    list << w if w
  end
end
