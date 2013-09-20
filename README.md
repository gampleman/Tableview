Tableview
=========


Tableview is a gem to be used in Rails to create table like views.

Installation
============


In your Gemfile:

    gem 'tableview'
     
then

    $ bundle install
    $ rails g tableview:install
    
Usage
=====
     
To apply to a resource use the built in generator:

    $ rails g tableview resource_name

This will create a partial named `_table.tv` in which you can use a DSL like this to define your table:

    => @registrations
    
    + :first_name
    + :surname
    + :address {|reg| reg.address + "\n" + reg.postcode }
    + :friends if format.html?
    
    if format.xls?
      = @registrations.some_scope, "Workbook title"
      = @registration.other_scope, "Works as title in other formats as well"
    end
    
DSL
===


The DSL is a simple superset of ruby with a few special characters (only work if first printable character on line, won't work with eval and friends).

Character | Meaning
----------|--------
 `=>`     | Use the passed collection for rendering and I18n
 `*`      | Pass a hash to this, is used to configure the formatters.
 `+`      | Defines a column. If passed a symbol, Tableview will use I18n to lookup the header and call the method on the model to get the value. Strings will be used literally. Optionally use a block to generate values.
 `=`      | Render a subtable for the passed collection. Not all formatters support subtables, use at own risk (notably the CSV formatter has no support for this). Is meant mainly to have nice full-featured excel files.
 
What if I don't like the DSL?
=============================

You may simply create a `.rb` file instead, it will just have to include some boilerplate code (same result as above):

    format = Tableview::Helper::Format.new(params)
    tv = Tableview::ViewHandler.table do |table|
      table.table_for @registrations
    
      table.column :first_name
      table.column :surname
      table.column :address {|reg| reg.address + "\n" + reg.postcode }
      table.column :friends if format.html?
      
      if format.xls?
        table.generate_subtable_for @registrations.some_scope, "Workbook title"
        table.generate_subtable_for @registration.other_scope, "Works as title in other formats as well"
      end
    end
    output = Tableview::output_class(params[:format]).new
    output.process(tv)
    output.to_s
 
It will also add a few lines of code to your controller:

- `self.responder = ApplicationResponder` this sets up the correct code path to use for dynamically rendering all the formats.
- `respond_to :html, :json, :csv, :xls, :ascii` a list of supported formats. You will want to use `respond_with` as well.