# frozen_string_literal: true

class BloodlinesImporter
  def import
    bloodlines = EveOnline::ESI::Bloodlines.new.bloodlines

    bloodlines.each do |bloodline|
      eve_bloodline = Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)

      eve_bloodline.update!(bloodline.as_json)
    end
  end
end
