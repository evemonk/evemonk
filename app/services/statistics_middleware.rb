# frozen_string_literal: true

class StatisticsMiddleware < Faraday::Middleware
  def call(request_env)
    @app.call(request_env).on_complete do |response_env|
      method = "esi_requests_#{response_env[:status]}_counter"

      Yabeda.evemonk.public_send(method).increment({total: "success"}, by: 1)
    end
  end
end
