require 'action_view'
require 'coffee-script'

module CoffeeViews
  module Handlers
    module CoffeeScript
      def self.erb_handler
        @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end
      
      def self.prepare source
        source ||= ""
        source.gsub! /<%==(.*?)%>/,     '`<%==\1%>`'
        source.gsub! /<%=([^=].*?)%>/,  '`<%==(\1).to_json%>`'
        source.gsub! /<%([^=].*?)%>/,   '`<%\1%>`'
        source.gsub! /#\{==(.*?)\}/,    '#{`<%==\1%>`}'
        source.gsub! /#\{=([^=].*?)\}/, '#{`<%==(\1).to_json%>`}'
        source
      end

      def self.call(template)
        source = self.prepare(template.source)
        source = ::CoffeeScript.compile(source)
        # TODO: find how to set source back to template without instance_variable_set
        template.instance_variable_set :@source, source

        erb_handler.call(template)
      end
    end
  end
  
  ActionView::Template.register_template_handler :coffee, CoffeeViews::Handlers::CoffeeScript
end