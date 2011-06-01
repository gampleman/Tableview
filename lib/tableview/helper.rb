module Tableview::Helper
  
  class Format
    def initialize(p)
      @params = p
    end
    
    def html?
      @params[:format] == :html || @params[:format].blank?
    end
    
    def method_missing(name, *args, &blk)
      puts name.inspect
      if m = name.to_s.match(/^(.+)\?$/)
        puts "matched"
        #puts m.inspect, name.inspect
        @params[:format] == m.captures.first
      else
        puts "did not match"
        super
      end
    end
    
  end
end