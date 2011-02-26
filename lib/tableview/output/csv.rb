module Tableview::Ouput
  class CSV
    require 'csv'
    def process(tv)
      @table = CSV.generate("") { |csv|
        tv.parts.each do |part|
          part.rows.each do |row|
            csv << row.cells.map {|cell| cell.contents }
          end
        end
      }
    end
    
    def to_s
      @table.to_s
    end
    
  end
end