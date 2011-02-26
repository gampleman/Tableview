require 'action_dispatch/http/mime_type'
Mime::Type.register "application/vnd.ms-excel", :xls

require 'tableview/tv'
require 'tableview/view_handler'



ActionView::Template.register_template_handler 'tv', Tableview::TV

module Tableview
  def output_class(format)
    require File.join(File.dirname(__FILE__), "tableview", "output", format.to_s.downcase)
    rescue e
      puts "Unknown ouput format"
    end
    format.to_s.upcase.constantize
  end
end