# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationImporter do
  let(:corporation_id) { double }

  subject { described_class.new(corporation_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import!" do
    context "when eve corporation found" do
      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before { expect(subject).to receive(:eve_corporation).and_return(eve_corporation) }

      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::Corporation, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_corporation).to receive(:update!).with(json) }

      specify { expect { subject.import! }.not_to raise_error }
    end

    context "when eve corporation not found" do
      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before { expect(subject).to receive(:eve_corporation).and_return(eve_corporation).twice }

      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before { expect(eve_corporation).to receive(:destroy!) }

      specify { expect { subject.import! }.not_to raise_error }
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
