# frozen_string_literal: true

require "rails_helper"

describe Eve::ServerStatusImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    let(:json) { double }

    let(:esi) { instance_double(EveOnline::ESI::ServerStatus, as_json: json) }

    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(EveOnline::ESI::ServerStatus).to receive(:new).and_return(esi) }

    before { expect(Eve::ServerStatus).to receive(:create!).with(json) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::ServerStatus) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::ServerStatus) }

      before { expect(EveOnline::ESI::ServerStatus).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
