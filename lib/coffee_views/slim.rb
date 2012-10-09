require 'action_view'
ActiveSupport.on_load(:action_view) do
  if Object.const_defined?(:Slim)

    module CoffeeViews
      class CoffeeViewEngine < Slim::EmbeddedEngine::ERBEngine
        def on_slim_embedded(engine, body)
         source = CoffeeViews::Rails::TemplateHandler.compile_coffee(collect_text(body))
         [:multi, [:newline], Temple::ERB::Parser.new.call(source)]
        end

        protected

        def collect_text(body)
          ::Slim::TextCollector.new.call(body)
        end
      end
      
      Slim::EmbeddedEngine.register :coffeeview,
                                    ::Slim::EmbeddedEngine::TagEngine,
                                    :tag => :script,
                                    :attributes => { :type => 'text/javascript' },
                                    :engine => CoffeeViewEngine
    end
  end
end