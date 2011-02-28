module Tableview
  module Responder
    
    def initialize(controller, resources, options={})
      super
    end
    
    def to_html
      super
    end
    
    def to_csv
      send_file(render :partial => "table")
    end
    
    def to_xls
      send_file(render :partial => "table")
    end
    
    def to_ascii
      render :partial => "table"
    end
    
  end
end