# frozen_string_literal: true

class AncestriesImporter
  def import
    ancestries = EveOnline::ESI::Ancestries.new

    ancestries.ancestries.each do |ancestry|
      Eve::Ancestry.create!(ancestry.as_json)
    end
  end
end
