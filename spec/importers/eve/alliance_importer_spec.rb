# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AllianceImporter do
  describe "#import" do
    context "when alliance is exist" do
      before { VCR.insert_cassette "esi/alliances/1354830081" }

      after { VCR.eject_cassette }

      subject { described_class.new(1_354_830_081) }

      specify { expect { subject.import }.to change(Eve::Alliance, :count).by(1) }
    end

    context "when alliance is not exist anymore" do
      before { VCR.insert_cassette "esi/alliances/111222" }

      after { VCR.eject_cassette }

      let!(:alliance) { create(:eve_alliance, id: 111_222) }

      subject { described_class.new(111_222) }

      specify { expect { subject.import }.to change(Eve::Alliance, :count).by(-1) }
    end
  end
end
