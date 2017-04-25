module Api
  class ApiKeyValidate
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def call
      # TODO: write validation
    end
  end
end
