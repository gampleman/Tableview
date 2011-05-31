require 'rails'

module Tableview
  module Generators
    class InstallGenerator < ::Rails::Generator::Base
      desc "Creates the responder file necessary for proper working of the plugin."
      def create_application_responder
        # record do |m|
        #         m.file "definition.txt", "definition.txt"
        #       end
        lib 'application_responder.rb', "class ApplicationResponder < ActionController::Responder\n\tinclude Tableview::Responder\nend"
      
      end
    end
  end
end