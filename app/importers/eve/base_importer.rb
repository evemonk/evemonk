# frozen_string_literal: true

module Eve
  class BaseImporter
    def import!
      configure_middlewares

      ActiveRecord::Base.transaction do
        yield if block_given?
      end
    end

    def esi
      raise NotImplementedError
    end

    def import
      raise NotImplementedError
    end

    private

    def configure_middlewares
      esi.add_middleware(statistics_middleware)

      esi.add_middleware(cool_down_middleware)
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

    def cache
      Rails.cache
    end
  end
end
