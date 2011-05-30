require 'tableview/helper'
module Tableview
  class ViewHandler
    
    
    
    attr_reader :table
    
    def self.table(opts = {}, &block)
      ret = Table.new opts
      #ret.instance_eval &block
      yield(ret)
      ret.create_table!
      ret
    end
    
    class TablePiece
      attr_accessor :options
      def initialize(opts = {})
        self.options = opts
      end
    end
  
    class Table < TablePiece
      attr_accessor :parts
      def initialize(*args)
        super *args
        self.parts = []
        @current_part = Body.new
        @added = false
        @headers, @procs = [], []
      end
      
      def table_for(s)
        @collection = s
      end
      
      def config(opts)
        self.options = opts
      end
      
      def part(obj, opts, &block)
        prev = @current_part
        added = @added
        @added = true
        @current_part = obj.new opts
        yield @current_part
        self.parts << @current_part
        @current_part = prev
        @added = added
      end

      def header(opts = {}, &block)
        self.part Header, opts, &block
      end

      def header_row(opts = {}, &block)
        self.header do |table|
          table.row opts, &block
        end
      end

      def footer(opts = {}, &block)
        self.part Footer, opts, &block
      end

      def footer_row(opts = {}, &block)
        self.footer do |t|
          t.row opts, &block
        end
      end

      def body(opts = {}, &block)
        self.part Body, opts, &block
      end
      
      def row(opts = {}, &block)
        unless @added
          @parts << @current_part
          @added = true
        end
        @current_part.send :row, opts, &block
      end
      
      def column(title, opts = {}, header_opts = {}, row_opts = {}, &block)
        if title.is_a? Symbol
          method = title unless block_given?
          title = I18n.translate("activerecord.attributes.#{@collection.klass.name.downcase}.#{title}")
        end
        if block_given?
          proc = block#lambda { |val| block.call(val) }
        else
          proc = lambda { |val| val.send(method) }
        end
        
        @headers << Cell.new(title, opts.merge(header_opts))
        @procs << proc
        @column_based = true
      end
      
      def columns(*titles)
        titles.each do |title|
          self.column title
        end
      end
      
      def create_table!
        return unless @column_based
        header_row do |row|
          row.cells = @headers
        end
        @collection.each do |el|
          row do |r|
            @procs.each do |proc|
              r.cell proc.call(el)
            end
          end
        end
      end
      
    end
  
    class Part < TablePiece
      attr_accessor :rows
      def initialize(*args)
        super *args
        self.rows = []
      end
      
      def row(opts = {}, &block)
        row = Row.new opts
        yield row
        self.rows << row
      end
    end
  
    class Header < Part
    
    end
  
    class Body < Part
    
    end
  
    class Footer < Part
    
    end
  
    class Row < TablePiece
      attr_accessor :cells
      def initialize(*args)
        super *args
        self.cells = []
      end
      
      def cell(*contents)
        opts = contents.extract_options!.symbolize_keys
        contents.each do |c|
          self.cells << Cell.new(c, opts)
        end
      end

      #alias_method :cells, :cell
      
    end
  
    class Cell < TablePiece
      attr_accessor :contents
      def initialize(contents, opts)
        self.contents = contents
        super opts
      end
    end
    
    
  end
end


  