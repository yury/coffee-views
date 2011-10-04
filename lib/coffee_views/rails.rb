require 'action_view'
require 'coffee-rails'
require 'coffee-script'

module CoffeeViews
  module Rails
    class TemplateHandler
      def self.erb_handler
        @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end
      
      def self.preprocess source
        return "" unless source

        source.gsub! /<%==(.*?)%>/,     '`<%==\1%>`'
        source.gsub! /<%=([^=].*?)%>/,  '`<%==(\1).to_json%>`'
        source.gsub! /<%([^=].*?)%>/,   '`<%\1%>`'
        source.gsub! /#\{==(.*?)\}/,    '#{`<%==\1%>`}'
        source.gsub! /#\{=([^=].*?)\}/, '#{`<%==(\1).to_json%>`}'
        source
      end
      
      def self.compile_coffee(source)
        source = preprocess(source)
        ::CoffeeScript.compile(source)
      end

      def self.call(template)
        source = compile_coffee(template.source)
        # TODO: find how to set source back to template without instance_variable_set
        template.instance_variable_set :@source, source

        erb_handler.call(template)
      end
    end
  end
  
  ActiveSupport.on_load(:action_view) do
    ActionView::Template.register_template_handler :coffee, CoffeeViews::Rails::TemplateHandler
  end
end