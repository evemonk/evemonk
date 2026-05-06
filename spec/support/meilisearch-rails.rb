# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    Eve::Alliance.clear_index!
    Eve::Alliance.reindex!

    Eve::Corporation.clear_index!
    Eve::Corporation.reindex!

    Eve::Character.clear_index!
    Eve::Character.reindex!

    Eve::Type.clear_index!
    Eve::Type.reindex!
  end

  config.before do
    Eve::Alliance.clear_index!
    Eve::Alliance.reindex!

    Eve::Corporation.clear_index!
    Eve::Corporation.reindex!

    Eve::Character.clear_index!
    Eve::Character.reindex!

    Eve::Type.clear_index!
    Eve::Type.reindex!
  end
end
