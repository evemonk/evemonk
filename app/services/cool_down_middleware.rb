# frozen_string_literal: true

class CoolDownMiddleware < Faraday::Middleware
  def initialize(app = nil, options = {})
    @app = app
    @esi = options.fetch(:esi)
  end

  def call(request_env)
    @app.call(request_env).on_complete do |response_env|
    end
  end
end
