module Tableview::Helper
  
  class Format
    def initialize(p)
      @params = p
    end
    
    def html?
      @params[:format] == :html || @params[:format].blank?
    end
    
    def method_missing(name, *args, &blk)
      if m = name.to_s.match(/^(.+)\?$/)
        @params[:format] == m.captures.first
      else
        super
      end
    end
    
  end
end