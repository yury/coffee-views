require 'action_view'
require 'coffee-script'

module CoffeeViews
  module Handlers
    module CoffeeScript
      def self.erb_handler
        @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end
      
      def self.preprocess source
        source ||= ""
        source.gsub! /<%==(.*?)%>/,     '`<%==\1%>`'
        source.gsub! /<%=([^=].*?)%>/,  '`<%==(\1).to_json%>`'
        source.gsub! /<%([^=].*?)%>/,   '`<%\1%>`'
        source.gsub! /#\{==(.*?)\}/,    '#{`<%==\1%>`}'
        source.gsub! /#\{=([^=].*?)\}/, '#{`<%==(\1).to_json%>`}'
        source
      end
      
      def self.compile_coffee(source)
        source = self.preprocess(source)
        ::CoffeeScript.compile(source)
      end

      def self.call(template)
        source = self.compile_coffee(template.source)
        # TODO: find how to set source back to template without instance_variable_set
        template.instance_variable_set :@source, source

        erb_handler.call(template)
      end
    end
  end
  
  ActionView::Template.register_template_handler :coffee, CoffeeViews::Handlers::CoffeeScript
  
  if defined?(Slim)
    class CoffeeViewEngine < Slim::EmbeddedEngine::ERBEngine
      def on_slim_embedded(engine, body)
       source = CoffeeViews::Handlers::CoffeeScript.compile_coffee(collect_text(body))
       source = Temple::ERB::Parser.new.call(source)
      end
    end
    Slim::EmbeddedEngine.register :coffeeview,  Slim::EmbeddedEngine::TagEngine,  :tag => :script, :attributes => { :type => 'text/javascript' }, :engine => CoffeeViewEngine
  end
end