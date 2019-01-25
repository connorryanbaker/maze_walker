require_relative 'grid'
require_relative 'cell'
require_relative 'cursor'
class Sidewinder
  def self.on(grid)
    grid.each_row do |row|
      run = []

      row.each do |cell|
        run << cell

        at_eastern_boundary = (cell.e == nil)
        at_northern_boundary = (cell.n == nil)

        should_close_out = 
          at_eastern_boundary || (!at_northern_boundary && rand(2) == 0)

        if should_close_out
          member = run.sample
          member.link(member.n) if member.n
          run.clear
        else
          cell.link(cell.e)
        end
      end
    end

    grid
  end
end
