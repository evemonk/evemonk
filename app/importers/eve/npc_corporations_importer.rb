# frozen_string_literal: true

module Eve
  class NpcCorporationsImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::CorporationNPC.new
    end

    def import
      ActiveRecord::Base.transaction do
        esi.etag = etag.etag

        return if esi.not_modified?

        update_npc_corporation_list

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def etag
      @etag ||= Eve::Etag.find_or_initialize_by(url: esi.url)
    end

    def update_npc_corporation_list
      esi.corporation_npc_ids.each do |corporation_npc_id|
        corporation = Eve::Corporation.find_or_initialize_by(corporation_id: corporation_npc_id)

        corporation.assign_attributes(npc: true)

        corporation.save!
      end
    end
  end
end
