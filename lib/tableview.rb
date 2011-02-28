require 'action_dispatch/http/mime_type'
Mime::Type.register "application/vnd.ms-excel", :xls
Mime::Type.register "text/plain", :ascii


require 'tableview/tv'
require 'tableview/view_handler'



ActionView::Template.register_template_handler 'tv', Tableview::TV.new

module Tableview
  def self.output_class(format)
    format = :html if format.blank?
    begin
      require File.join(File.dirname(__FILE__), "tableview", "output", format.to_s.downcase)
    rescue 
      raise NoOuputClassError
    end
    ("Tableview::Ouput::" + format.to_s.upcase).constantize
  end
  
  class NoOuputClassError
  end
  
end
