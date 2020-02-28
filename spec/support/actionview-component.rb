require "action_view/component/test_helpers"

RSpec.configure do |config|
  config.include ActionView::Component::TestHelpers, type: :component
end
