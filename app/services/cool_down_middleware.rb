# frozen_string_literal: true

class CoolDownMiddleware < Faraday::Middleware
  def on_request(_)
    error_limit_remain = redis.get("esi_error_limit_remain")
    esi_error_limit_remain_till = redis.get("esi_error_limit_remain_till")

    if error_limit_remain
      remain = error_limit_remain.to_i
      if remain < 50
        seconds = ActiveSupport::TimeZone["UTC"].parse(esi_error_limit_remain_till)
        sleep(seconds)
      end
    end
  end

  def on_complete(env)
    esi_error_limit_remain = env[:response_headers]["x-esi-error-limit-remain"]
    esi_error_limit_reset = env[:response_headers]["x-esi-error-limit-reset"]

    if esi_error_limit_remain && esi_error_limit_reset
      redis.set("esi_error_limit_remain",
        esi_error_limit_remain.to_i,
        ex: esi_error_limit_reset.to_i)

      redis.set("esi_error_limit_remain_till",
        esi_error_limit_reset.to_i.seconds.from_now.iso8601,
        ex: esi_error_limit_reset.to_i)
    end
  end

  def redis
    Redis.new
  end
end
