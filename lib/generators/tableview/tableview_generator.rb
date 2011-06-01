require 'rails'

module Tableview
  module Generators
    class TableviewGenerator < ::Rails::Generators::NamedBase
      namespace "tableview"
      desc "Generates a partial and some controller code to use tableview."
      def create_partial
        cols = file_name.camelize.constantize.column_names
        template = "=> @#{file_name.tableize}\n\n"
        cols.each do |col|
          template << "+ :#{col}\n"
        end
        create_file "app/views/#{file_name.tableize}/_table.tv", template
      end
      
      def install_into_controller
        inject_into_class "app/controllers/#{file_name.tableize}_controller.rb", file_name.camelize.pluralize + "Controller", "  self.responder = ApplicationResponder\n  respond_to :html, :json, :csv, :xls, :ascii"
      end
      
    end
  end
end