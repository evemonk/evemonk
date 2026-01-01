# frozen_string_literal: true

module Eve
  class BaseImporter
    def import!
      # configure_middlewares

      ActiveRecord::Base.transaction do
        yield if block_given?
      end
    end

    def client
      raise NotImplementedError
    end

    def import
      raise NotImplementedError
    end

    private

    def configure_middlewares
      client.add_middleware(statistics_middleware)

      client.add_middleware(cool_down_middleware)
    end

    def statistics_middleware
      {
        class: StatisticsMiddleware
      }
    end

    def cool_down_middleware
      {
        class: CoolDownMiddleware
      }
    end
  end
end
