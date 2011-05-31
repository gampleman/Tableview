module Tableview::Output
  class ASCII
    require 'terminal-table/import'
    def process(tv)
      @table = ""
      tv.subtables.each do |sub|
        @table << "# #{sub.title}" unless sub.title.blank?
        @table << table { |t|
          sub.parts.each do |part|
            part.rows.each do |row|
              t.add_row row.cells.map {|cell| {:value => cell.contents}.merge(cell.options) }
            end
            t.add_separator unless part == sub.parts.last
          end
        }.to_s
      end
    end
    
    def to_s
      @table
    end
    
  end
end