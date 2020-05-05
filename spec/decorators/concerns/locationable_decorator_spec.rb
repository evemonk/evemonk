# frozen_string_literal: true

require "rails_helper"

describe LocationableDecorator do
  describe "#location_formatted" do
    context "when location is eve station" do
      let!(:eve_station) do
        create(:eve_station,
          station_id: 60_008_494,
          system_id: 30_002_187,
          name: "Amarr VIII (Oris) - Emperor Family Academy")
      end

      let!(:eve_system) do
        create(:eve_system,
          system_id: 30_002_187,
          security_status: 1.0)
      end

      let!(:character_blueprint) do
        create(:character_blueprint,
          location_id: 60_008_494)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.location_formatted).to eq("Amarr VIII (Oris) - Emperor Family Academy (1.0)") }
    end
  end
end
