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

    => @registrations
    
    + :first_name
    + :surname
    + :address {|reg| reg.address + "\n" + reg.postcode }
    + :friends if format.html?
    
    if format.xls?
      = @registrations.some_scope, "Workbook title"
      = @registration.other_scope, "Works as title in other formats as well"
    end
    
The DSL is a simple superset of ruby with a few special characters (only work if first printable character on line, won't work with eval and friends).

Character | Meaning
----------|--------
 `=>`     | Use the passed collection for rendering and I18n
 `*`      | Pass a hash to this, is used to configure the formatters.
 `+`      | Defines a column. If passed a symbol, Tableview will use I18n to lookup the header and call the method on the model to get the value. Strings will be used literally. Optionally use a block to generate values.
 `=`      | Render a subtable for the passed collection. Not all formatters support subtables, use at own risk (notably the CSV formatter has no support for this). Is meant mainly to have nice full-featured excel files.