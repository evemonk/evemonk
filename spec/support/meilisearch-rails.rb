# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    Eve::Alliance.reindex!
    Eve::Corporation.reindex!
    Eve::Character.reindex!
    Eve::Type.reindex!
  end
end
