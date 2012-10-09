require 'action_view'
ActiveSupport.on_load(:action_view) do
  if Object.const_defined?(:Slim)

    module CoffeeViews
      class CoffeeViewEngine < Slim::EmbeddedEngine::ERBEngine
        def on_slim_embedded(engine, body)
          erb = collect_text(body)
          source = CoffeeViews::Rails::TemplateHandler.compile_coffee(erb)
          [:multi, [:newline], erb_parser.call(source)]
        end

        def erb_parser
          @erb_parser ||= Temple::ERB::Parser.new
        end

        protected

        if !::Slim.const_defined?(:TextCollector)
          def collect_text(body)
            ::Slim::CollectText.new.call(body)
          end
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