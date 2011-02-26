module Tableview
  class TV 
    def call(template)
      %{
        tv = Tableview::ViewHandler.table do
          #{template.source}
        end
        output = Tableview::output_class(params[:format]).new
        output.process(tv)
        output.to_s
      }
    end
    
  end
end