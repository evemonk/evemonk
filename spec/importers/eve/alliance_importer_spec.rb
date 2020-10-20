# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceImporter do
  let(:alliance_id) { double }

  subject { described_class.new(alliance_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import!" do
    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      expect(Eve::Alliance).to receive(:find_or_initialize_by)
        .with(alliance_id: alliance_id)
        .and_return(eve_alliance)
    end

    context "when eve alliance found" do
      let(:json) { double }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Alliance,
          as_json: json,
          response: response)
      end

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_alliance).to receive(:update!).with(json) }

      specify { expect { subject.import! }.not_to raise_error }
    end

    context "when alliance not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before { expect(eve_alliance).to receive(:destroy!) }

      specify { expect { subject.import! }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::Alliance) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::Alliance) }

      before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
