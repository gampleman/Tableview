module Tableview
  module Responder
    
    #def initialize(controller, resources, options={})
    #  super
    #end
    
    
    def to_html
      super
    end
    
    def to_format
      puts "#to_format with format=#{format.inspect} called"
    end
    
    def to_csv
      puts "#to_csv called"
      send_file(render :partial => "table")
    end
    
    def to_xls
      send_file(render :partial => "table")
    end
    
    def to_ascii
      puts "#to_ascii called"
      render :partial => "table"
    end
    
  end
end