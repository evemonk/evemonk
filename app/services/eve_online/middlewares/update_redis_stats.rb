# frozen_string_literal: true

module EveOnline
  module Middlewares
    class UpdateRedisStats
      attr_reader :esi, :redis

      def initialize(esi, redis = Redis.current)
        @esi = esi
        @redis = redis
      end

      def call
        update_limits
      end

      private

      def update_limits
        redis.set("esi_error_limit_remain", esi.error_limit_remain)
        redis.set("esi_error_limit_reset", esi.error_limit_reset)
      end
    end
  end
end
