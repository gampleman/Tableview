Tableview
=========


Tableview is a gem to be used in Rails to create table like views.

Installation
============


In your Gemfile:


    gem 'tableview'
     
then

    $ bundle install
     
Create a file in `/lib/application_responder.rb` with:

    class ApplicationResponder < ActionController::Responder
      include Tableview::Responder
    end
    
Then add this to your controller:

    require "#{Rails.root}/lib/application_responder"
    self.responder = ApplicationResponder
    respond_to :html, :csv, :xls, :ascii, :only => :index

Then create a partial named `_table.tv` in which you can use a DSL like this to define your table:

    table.header_row do |row|
      row.cell "First header cell", :align => :right
      row.cell "You can do", "more cells at once"
    end
    
    @posts.each do |post|
      table.row do |row|
        row.cell post.title
        row.cell post.body if format.xls?
      end
    end
    
This partial will be used to render your view.

### NEW! ###

We now have a column based DSL.

    table.table_for @events
    
    # uses I18n for header and calls the symbol as a method on the object
    table.columns :first_name, :last_name 
    # Uses first arg as header, and evaluates block for each row
    table.column("E-mail address") {|event| format.html? link_to event.email : event.email }
