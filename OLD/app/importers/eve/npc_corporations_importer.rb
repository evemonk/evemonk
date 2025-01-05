# frozen_string_literal: true

module Eve
  class NpcCorporationsImporter < BaseImporter
    def import
      import! do
        update_npc_corporation_list
      end
    end

    def esi
      @esi ||= EveOnline::ESI::CorporationNPC.new
    end

    private

    def update_npc_corporation_list
      esi.corporation_npc_ids.each do |corporation_npc_id|
        corporation = Eve::Corporation.find_or_initialize_by(id: corporation_npc_id)

        corporation.assign_attributes(npc: true)

        corporation.save!
      end
    end
  end
end
