# frozen_string_literal: true

class AncestriesImporter
  def import
    ancestries = EveOnline::ESI::Ancestries.new.ancestries

    ancestries.each do |ancestry|
      eve_ancestry = Eve::Ancestry.find_or_initialize_by(ancestry_id: ancestry.ancestry_id)

      eve_ancestry.update!(ancestry.as_json)
    end
  end
end
