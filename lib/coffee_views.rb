require 'coffee-script'

module CoffeeViews
  module Handlers
    module CoffeeScript
      def self.erb_handler
        @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end

      def self.call(template)
        src = template.source
        src = src.gsub(/<%=([^=].*?)%>/, '`<%==(\1).to_json%>`')
        src = src.gsub(/<%([^=].*?)%>/, '`<%\1%>`')
        src = src.gsub(/[^`]<%==(.*?)%>/, '`<%==\1%>`')
        src = src.gsub(/#\{=(.*?)\}/, '#{`<%=(\1).to_json%>`}')
        src = src.gsub(/#\{==(.*?)\}/, '#{`<%== \1 %>`}')
        
        # TODO: find how to set source back to template without instance_variable_set
        template.instance_variable_set :@source, src

        erb_handler.call(template)
      end
    end
  end
  
  ActionView::Template.register_template_handler :coffee, CoffeeViews::Handlers::CoffeeScript
end