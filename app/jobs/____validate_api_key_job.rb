class ValidateApiKeyJob < ApplicationJob
  queue_as :default

  def perform(api_key_id)
    ValidateApiKey.call(api_key_id)
  end
end
