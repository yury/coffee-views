require 'coffee_views/rails'
require 'coffee_views/slim'
require 'coffee_views/version'

module CoffeeViews
  # http://jfire.io/blog/2012/04/30/how-to-securely-bootstrap-json-in-a-rails-view/
  def self.j s
    result = s.to_s.gsub('/', '\/')
    s.html_safe? ? result.html_safe : result
  end
end