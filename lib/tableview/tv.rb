module Tableview
  class TV 
    def call(template)
      source = template.source
      start, ending = /^\s*/, /\s+(.+?)(?= unless| if| do|\{|#|$)/
      source.gsub!(/#{start}\+#{ending}/, 'table.column(\1)')
      source.gsub!(/#{start}\=>#{ending}/, 'table.table_for(\1)')
      source.gsub!(/#{start}\=#{ending}/, 'table.generate_subtable_for(\1)')
      source.gsub!(/#{start}\*#{ending}/, 'table.config(\1)')
      %{
        format = Tableview::Helper::Format.new(params)
        tv = Tableview::ViewHandler.dsl do |table|
          #{source}
        end
        output = Tableview::output_class(params[:format]).new
        output.process(tv)
        output.to_s
      }
    end
    
  end
end