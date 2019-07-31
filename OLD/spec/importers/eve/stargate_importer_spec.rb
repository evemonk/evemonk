# frozen_string_literal: true

require "rails_helper"

describe Eve::StargateImporter do
  describe "#import" do
    context "when import ok" do
      let(:stargate_id) { double }

      subject { described_class.new(stargate_id) }

      before { expect(Eve::Stargate).to receive(:find_or_initialize_by).with(stargate_id: stargate_id).and_return(eve_stargate) }

      let(:json) { double }

      let(:stargate) { instance_double(EveOnline::ESI::UniverseStargate, as_json: json) }

      before { expect(EveOnline::ESI::UniverseStargate).to receive(:new).with(id: stargate_id).and_return(stargate) }

      before { expect(eve_stargate).to receive(:assign_attributes).with(json) }

      context "when stargate changed" do
        let(:eve_stargate) { instance_double(Eve::Stargate, changed?: true) }

        before { expect(eve_stargate).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when stargate not changed" do
        let(:eve_stargate) { instance_double(Eve::Stargate, changed?: false) }

        before { expect(eve_stargate).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when stargate not found" do
      let(:stargate_id) { double }

      subject { described_class.new(stargate_id) }

      before { expect(Eve::Stargate).to receive(:find_or_initialize_by).with(stargate_id: stargate_id).and_return(eve_stargate) }

      before { expect(EveOnline::ESI::UniverseStargate).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      context "when stargate persisted" do
        let(:eve_stargate) { instance_double(Eve::Stargate, persisted?: true) }

        before { expect(eve_stargate).to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when stargate not persisted" do
        let(:eve_stargate) { instance_double(Eve::Stargate, persisted?: false) }

        before { expect(eve_stargate).not_to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end
end
