require_relative 'distances'
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
    list
  end

  def distances
    distances = Distances.new(self)
    frontier = [ self ]
    while frontier.any?
      new_frontier = []
      frontier.each do |cell|
        cell.links.each do |linked|
          next if distances[linked]
          distances[linked] = distances[cell] + 1
          new_frontier << linked
        end
      end
      frontier = new_frontier
    end
    distances
  end
end
