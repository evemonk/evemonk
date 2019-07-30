# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemsImporter do
  describe "#import" do
    let(:system_id) { double }

    let(:eveonline_systems) { instance_double(EveOnline::ESI::UniverseSystems, universe_system_ids: [system_id]) }

    before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(eveonline_systems) }

    before { expect(Eve::SystemImporterWorker).to receive(:perform_async).with(system_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
