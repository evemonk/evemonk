# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::BloodlinesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "with default locale" do
      before { VCR.insert_cassette "esi/universe/bloodlines" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.to change(Eve::Bloodline, :count).by(18) }

      specify "" do
        subject.import

        bloodline = Eve::Bloodline.first

        expect(bloodline.id).to eq(1)

        expect(bloodline.charisma).to eq(6)

        expect(bloodline.corporation_id).to eq(1_000_006)

        expect(bloodline.description_en).to start_with("The Deteis are regarded as the face of leadership in Caldari society.")

        expect(bloodline.intelligence).to eq(7)

        expect(bloodline.memory).to eq(7)

        expect(bloodline.name_en).to eq("Deteis")

        expect(bloodline.perception).to eq(5)

        expect(bloodline.race_id).to eq(1)

        expect(bloodline.ship_type_id).to eq(601)

        expect(bloodline.willpower).to eq(5)
      end
    end
  end
end
