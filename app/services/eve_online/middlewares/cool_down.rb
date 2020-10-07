# frozen_string_literal: true

module EveOnline
  module Middlewares
    class CoolDown
      attr_reader :esi, :redis

      def initialize(esi, redis = Redis.current)
        @esi = esi
        @redis = redis
      end

      def call
        check_and_wait
      end

      private

      def check_and_wait
        return if redis.get("esi_error_limit_remain") > 50

        sleep(redis.get("esi_error_limit_reset"))
      end
    end
  end
end
