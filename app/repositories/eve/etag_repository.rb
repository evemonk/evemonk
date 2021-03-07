# frozen_string_literal: true

module Eve
  class EtagRepository
    class << self
      def find_by_url(url)
        record = EtagRecord.find_or_initialize_by(url: url)
        to_model(record.attributes)
      end

      def update_by_url(url, input)
        record = EtagRecord.find_or_initialize_by(url: url)
        record.update!(url: input.url,
                       etag: input.etag,
                       body: input.body)
        to_model(record.attributes)
      end

      def destroy(url)
        record = EtagRecord.find_or_initialize_by(url: url)
        record.destroy!
      end

      private

      def to_model(attributes)
        Etag.new(**attributes.symbolize_keys)
      end
    end
  end
end
