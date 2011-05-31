require 'rails'

module Tableview
  module Generators
    class PartialGenerator < ::Rails::Generators::NamedBase
      
      def create_partial
        cols = file_name.constantize.new.column_names
        template = "=> @#{file_name.pluralize}\n"
        cols.each do |col|
          template << "+ :#{col}\n"
        end
      end
      
      
    end
  end
end