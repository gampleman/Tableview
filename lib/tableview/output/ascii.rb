module Tableview::Ouput
  class ASCII
    require 'terminal-table/import'
    def process(tv)
      @table = table { |t|
        tv.parts.each do |part|
          part.rows.each do |row|
            t.add_row row.cells.map {|cell| {:value => cell.contents}.merge(cell.options) }
          end
          t.add_separator unless part == tv.parts.last
        end
      }
    end
    
    def to_s
      @table.to_s
    end
    
  end
end