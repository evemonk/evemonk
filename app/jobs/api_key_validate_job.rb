class ApiKeyValidateJob < ApplicationJob
  queue_as :default

  def perform(api_key_id)
    api_key = ApiKey.find(api_key_id)

    Api::ApiKeyValidate.new(api_key).call
  end
end
