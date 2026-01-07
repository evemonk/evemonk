# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AllianceImporter do
  describe "#import" do
    before { VCR.insert_cassette "esi/alliances/1354830081" }

    after { VCR.eject_cassette }

    subject { described_class.new(1_354_830_081) }

    specify { expect { subject.import }.to change(Eve::Alliance, :count).by(1) }
  end

  # describe "#import" do
  #   before { expect(subject).to receive(:configure_middlewares) }
  #
  #   let(:eve_alliance) { instance_double(Eve::Alliance) }
  #
  #   before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(id: id).and_return(eve_alliance) }
  #
  #   context "when eve alliance resource found" do
  #     let(:json) { double }
  #
  #     let(:esi) { instance_double(EveOnline::ESI::Alliance, as_json: json) }
  #
  #     before { expect(subject).to receive(:esi).and_return(esi) }
  #
  #     before { expect(eve_alliance).to receive(:update!).with(json) }
  #
  #     before { expect(eve_alliance).to receive(:reset_corporations_count) }
  #
  #     before { expect(eve_alliance).to receive(:reset_characters_count) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  #
  #   context "when eve alliance resource not found" do
  #     before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }
  #
  #     before do
  #       #
  #       # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{id}")
  #       #
  #       expect(Rails).to receive(:logger) do
  #         double.tap do |a|
  #           expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{id}")
  #         end
  #       end
  #     end
  #
  #     before { expect(eve_alliance).to receive(:destroy!) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  # end
end
