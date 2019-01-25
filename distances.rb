class Distances
  def initialize(root)
    @root = root
    @cells = {}
    @cells[root] = 0
  end

  def [](cell)
    @cells[cell]
  end

  def []=(cell,distance)
    @cells[cell] = distance
  end

  def cells
    @cells.keys
  end

  def path_to(goal)
    current = goal
    breadcrumbs = Distances.new(@root)
    breadcrumbs[current] = @cells[current]

    until current == @root
      current.links.each do |cell|
        if @cells[cell] < @cells[current]
          breadcrumbs[cell] = @cells[cell]
          current = cell
          break
        end
      end
    end
    breadcrumbs
  end
end
