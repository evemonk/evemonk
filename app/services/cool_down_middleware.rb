# frozen_string_literal: true

class CoolDownMiddleware < Faraday::Middleware
  # def initialize(app = nil, options = {})
  #   super
  #
  #   # binding.pry
  #
  #   @esi = options.fetch(:esi)
  #   # @logger = options.fetch(:logger)
  #
  #   # binding.pry
  #
  #   # @app = app
  #   # @esi = options.fetch(:esi)
  #   # @logger = options.fetch(:logger)
  # end

  def on_request(env)


    # binding.pry
    #
    # puts "hi"

  end

  def on_complete(env)
    esi_error_limit_remain = env.response_headers["x-esi-error-limit-remain"]
    esi_error_limit_reset = env.response_headers["x-esi-error-limit-reset"]

    if esi_error_limit_remain && esi_error_limit_reset
      Redis.current.set("esi_error_limit_remain",
        esi_error_limit_remain.to_i,
        ex: esi_error_limit_reset.to_i)

      Redis.current.set("esi_error_limit_remain_till",
        esi_error_limit_reset.to_i.seconds.from_now,
        ex: esi_error_limit_reset.to_i)
    end
  end

  # def call(request_env)
  #   # do something with the request
  #   # request_env[:request_headers].merge!(...)
  #
  #   @app.call(request_env).on_complete do |response_env|
  #     # do something with the response
  #     # response_env[:response_headers].merge!(...)
  #   end
  # end
end
