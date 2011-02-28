module Tableview
  module Responder
    
    #def initialize(controller, resources, options={})
    #  super
    #end
    
    
    def to_html
      super
    end
    
    #def to_format
    #  puts "#to_format with format=#{format.inspect} called"
    #end
    
    def to_csv
      controller.send_data(controller.render_to_string :partial => "table")
    end
    
    def to_xls
      controller.send_data(controller.render_to_string :partial => "table")
    end
    
    def to_ascii
      render :partial => "table"
    end
    
  end
end