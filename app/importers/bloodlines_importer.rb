# frozen_string_literal: true

class BloodlinesImporter
  def import
    bloodlines = EveOnline::ESI::Bloodlines.new

    bloodlines.bloodlines.each do |bloodline|
      Eve::Bloodline.create!(bloodline.as_json)
    end
  end
end
