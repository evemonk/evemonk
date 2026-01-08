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

  # let(:corporation_id) { double }
  #
  # subject { described_class.new(corporation_id) }
  #
  # it { expect(subject).to be_a(Eve::BaseImporter) }
  #
  # describe "#import" do
  #   before { expect(subject).to receive(:configure_middlewares) }
  #
  #   let(:eve_corporation) { instance_double(Eve::Corporation) }
  #
  #   before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(id: corporation_id).and_return(eve_corporation) }
  #
  #   context "when eve corporation found" do
  #     let(:json) { double }
  #
  #     let(:esi) { instance_double(EveOnline::ESI::Corporation, as_json: json) }
  #
  #     before { expect(subject).to receive(:esi).and_return(esi) }
  #
  #     before { expect(eve_corporation).to receive(:update!).with(json) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  #
  #   context "when eve group not found" do
  #     before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }
  #
  #     before do
  #       #
  #       # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{corporation_id}")
  #       #
  #       expect(Rails).to receive(:logger) do
  #         double.tap do |a|
  #           expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{corporation_id}")
  #         end
  #       end
  #     end
  #
  #     before { expect(eve_corporation).to receive(:destroy!) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  # end
  #
  # describe "#esi" do
  #   context "when @esi is set" do
  #     let(:esi) { instance_double(EveOnline::ESI::Corporation) }
  #
  #     before { subject.instance_variable_set(:@esi, esi) }
  #
  #     specify { expect(subject.esi).to eq(esi) }
  #   end
  #
  #   context "when @esi not set" do
  #     let(:esi) { instance_double(EveOnline::ESI::Corporation) }
  #
  #     before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }
  #
  #     specify { expect(subject.esi).to eq(esi) }
  #
  #     specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
  #   end
  # end
end
