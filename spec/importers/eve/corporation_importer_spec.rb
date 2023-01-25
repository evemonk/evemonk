# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationImporter do
  let(:corporation_id) { double }

  subject { described_class.new(corporation_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_corporation) { instance_double(Eve::Corporation) }

    before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

    context "when eve corporation found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::Corporation, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_corporation).to receive(:update!).with(json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve group not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{corporation_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{corporation_id}")
          end
        end
      end

      before { expect(eve_corporation).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::Corporation) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::Corporation) }

      before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
