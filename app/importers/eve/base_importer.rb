# frozen_string_literal: true

module Eve
  class BaseImporter
    def import!
      configure_middlewares

      configure_etag

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

    def etag
      @etag ||= Eve::Etag.find_or_initialize_by(url: esi.url)
    end

    private

    def configure_middlewares
      esi.add_middleware(statistics_middleware)

      esi.add_middleware(cool_down_middleware)
    end

    def configure_etag
      esi.etag = etag.etag
    end

    def update_etag
      etag.update!(etag: esi.etag, body: esi.response)
    end

    def statistics_middleware
      {
        class: StatisticsMiddleware,
        logger: Rails.logger
      }
    end

    def cool_down_middleware
      {
        class: CoolDownMiddleware,
        logger: Rails.logger
      }
    end
  end
end
