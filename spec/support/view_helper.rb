# Advice on using Capybara for view testing
# http://ruby.11.n6.nabble.com/Rails-view-spec-expectations-matchers-td3491501.html

module RSpec::ViewHelper
  def page
    @page ||= Capybara::Node::Simple.new(rendered)
  end
end