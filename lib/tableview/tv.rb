module Tableview
  class TV 
    def call(template)
      %{
        format = Tableview::Helper::Format.new(params)
        tv = Tableview::ViewHandler.table do |table|
          #{template.source}
        end
        output = Tableview::output_class(params[:format]).new
        output.process(tv)
        output.to_s
      }
    end
    
  end
end