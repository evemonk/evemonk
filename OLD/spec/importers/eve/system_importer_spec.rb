# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemImporter do
  describe "#import" do
    context "when import ok" do
      let(:system_id) { double }

      subject { described_class.new(system_id) }

      before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: system_id).and_return(eve_system) }

      let(:json) { double }

      let(:stargate_id) { double }

      let(:system) { instance_double(EveOnline::ESI::UniverseSystem, as_json: json, stargate_ids: [stargate_id]) }

      before { expect(EveOnline::ESI::UniverseSystem).to receive(:new).with(id: system_id).and_return(system) }

      before { expect(eve_system).to receive(:assign_attributes).with(json) }

      before { expect(Eve::StargateImporterWorker).to receive(:perform_async).with(stargate_id) }

      context "when system changed" do
        let(:eve_system) { instance_double(Eve::System, changed?: true) }

        before { expect(eve_system).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when system not changed" do
        let(:eve_system) { instance_double(Eve::System, changed?: false) }

        before { expect(eve_system).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when system not found" do
      let(:system_id) { double }

      subject { described_class.new(system_id) }

      before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: system_id).and_return(eve_system) }

      before { expect(EveOnline::ESI::UniverseSystem).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      context "when system persisted" do
        let(:eve_system) { instance_double(Eve::System, persisted?: true) }

        before { expect(eve_system).to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when system not persisted" do
        let(:eve_system) { instance_double(Eve::System, persisted?: false) }

        before { expect(eve_system).not_to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end
end
