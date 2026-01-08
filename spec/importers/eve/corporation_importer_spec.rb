# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationImporter do
  describe "#import" do
    context "when corporation is exist" do
      before { VCR.insert_cassette "esi/corporations/98258093" }

      after { VCR.eject_cassette }

      subject { described_class.new(98_258_093) }

      specify { expect { subject.import }.to change(Eve::Corporation, :count).by(1) }
    end

    context "when corporation is not exist" do
      before { VCR.insert_cassette "esi/corporations/11222" }

      after { VCR.eject_cassette }

      let!(:corporation) { create(:eve_corporation, id: 11_222) }

      subject { described_class.new(11_222) }

      specify { expect { subject.import }.to change(Eve::Corporation, :count).by(-1) }
    end
  end
end
