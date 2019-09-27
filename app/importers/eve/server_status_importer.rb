# frozen_string_literal: true

module Eve
  class ServerStatusImporter
    def import
      ActiveRecord::Base.transaction do
        esi = EveOnline::ESI::ServerStatus.new

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        Eve::ServerStatus.create!(esi.as_json)

        etag.update!(etag: esi.etag)
      end
    end
  end
end
