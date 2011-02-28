module Tableview::Ouput
  class XLS
    require 'spreadsheet'
    HEADER_STYLE = {:align => :center, :weight => :bold, :size => 12}
    FOOTER_STYLE = {:weight => :bold }
    
    def process(tv)
      
      @table = Spreadsheet::Workbook.new

      sheet1 = @table.create_worksheet
      
      offset = 0

      tv.parts.each do |part|
        p_style = case part.class.to_s
        when "Tableview::ViewHandler::Header"
          HEADER_STYLE.dup
        when "Tableview::ViewHandler::Footer"
          FOOTER_STYLE.dup
        else
          {}
        end.merge part.options
        
        part.rows.each do |row|
          style = p_style.merge row.options
          row.cells.each_with_index do |cell, i|
            format = Spreadsheet::Format.new style.merge(cell.options)
            sheet1[offset, i] = cell.contents
            sheet1.row(offset).set_format i, format
          end
          offset += 1
        end
      end
      
    end
    
    def to_s
      io = StringIO.new
      @table.write(io)
      io.rewind
      string = io.read
    end
    
  end
end