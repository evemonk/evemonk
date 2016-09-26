class ValidateApiKey < Rectify::Command
  attr_reader :api_key_id

  def initialize(api_key_id)
    @api_key_id = api_key_id
  end

  def call
    api_key = ApiKey.find(api_key_id)

    api_key_info = EveOnline::Account::ApiKeyInfo.new(api_key.key_id, api_key.v_code)

    api_key.update!(api_key_info.as_json)

    broadcast(:ok)
  end
end
