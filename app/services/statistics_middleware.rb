# frozen_string_literal: true

class StatisticsMiddleware < Faraday::Middleware
  # def on_complete(env)
  #   method = "esi_requests_#{env[:status]}_counter"
  #
  #   Yabeda.evemonk.public_send(method).increment({total: "success"}, by: 1)
  # end
end
