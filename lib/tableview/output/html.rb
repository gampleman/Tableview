module Tableview::Ouput
  class HTML
    def process(tv)
      @table = ""
      @p = 0
      tag :table do
        
        tv.parts.each do |part|
          tag (case part.class.to_s
          when "Tableview::ViewHandler::Header"
            header = true
            :thead
          when "Tableview::ViewHandler::Footer"
            :tfoot
          when "Tableview::ViewHandler::Body"
            :tbody
          end) do 
        
            part.rows.each do |row|
              tag :tr do
                row.cells.each do |cell|
                  tag( header || cell.options[:header] ? :th : :td, cell.options) do 
                    @table += cell.contents.to_s
                  end #td / #th
                end
              end #tr
            end

          end #t{part}
        end
      end #table
    end
    
    def tag(tag, attributes = {})
      atrs = attributes.map {|k,v| " #{k}=\"#{v}\"" }.join
      @table += "\n#{" "*@p}<#{tag}#{atrs}>"
      @p += 2
      yield
      @p -= 2
      @table += "\n#{" " * @p}</#{tag}>"
    end
    
    def to_s
      @table.to_s
    end
    
  end
end