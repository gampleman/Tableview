module Tableview::Ouput
  class CSV
    require 'csv'
    def process(tv)
      @table = ::CSV.generate("") { |csv|
        tv.parts.each do |part|
          part.rows.each do |row|
            r = []
            row.cells.each do |cell| 
              r << cell.contents
              r += [nil] * (cell.options[:colspan] - 1) if cell.options[:colspan]
            end
            csv << r
          end
        end
      }
    end
    
    def to_s
      @table.to_s
    end
    
  end
end