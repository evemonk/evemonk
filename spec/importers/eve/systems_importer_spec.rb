# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemsImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::UniverseSystems) }

    before do
      expect(EveOnline::ESI::UniverseSystems).to receive(:new)
        .and_return(esi)
    end

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      let(:url) { double }

      let(:new_etag) { double }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseSystems,
          not_modified?: false,
          url: url,
          etag: new_etag,
          response: response)
      end

      before do
        expect(EveOnline::ESI::UniverseSystems).to receive(:new)
          .and_return(esi)
      end

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_systems) }

      before { expect(subject).to receive(:remove_old_systems) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseSystems,
          not_modified?: true,
          url: url)
      end

      before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(esi) }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(subject).not_to receive(:import_new_systems) }

      before { expect(subject).not_to receive(:remove_old_systems) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_new_systems" do
    let(:eve_systems_ids) { double }

    before { expect(Eve::System).to receive(:pluck).with(:system_id).and_return(eve_systems_ids) }

    let(:universe_system_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseSystems,
        universe_system_ids: universe_system_ids)
    end

    before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(esi) }

    let(:eve_system_id_to_create) { double }

    let(:eve_system_ids_to_create) { [eve_system_id_to_create] }

    before { expect(universe_system_ids).to receive(:-).with(eve_systems_ids).and_return(eve_system_ids_to_create) }

    before { expect(Eve::UpdateSystemJob).to receive(:perform_later).with(eve_system_id_to_create) }

    specify { expect { subject.send(:import_new_systems) }.not_to raise_error }
  end

  describe "#remove_old_systems" do
    let(:eve_systems_ids) { double }

    before { expect(Eve::System).to receive(:pluck).with(:system_id).and_return(eve_systems_ids) }

    let(:universe_system_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseSystems,
        universe_system_ids: universe_system_ids)
    end

    before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(esi) }

    let(:eve_system_id_to_remove) { double }

    let(:eve_system_ids_to_remove) { [eve_system_id_to_remove] }

    before { expect(eve_systems_ids).to receive(:-).with(universe_system_ids).and_return(eve_system_ids_to_remove) }

    let(:eve_system) { instance_double(Eve::System) }

    before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: eve_system_id_to_remove).and_return(eve_system) }

    before { expect(eve_system).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_systems) }.not_to raise_error }
  end
end
