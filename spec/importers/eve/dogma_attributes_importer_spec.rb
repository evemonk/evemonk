# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttributesImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::DogmaAttributes) }

    before do
      expect(EveOnline::ESI::DogmaAttributes).to receive(:new)
        .and_return(esi)
    end

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
          etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:new_etag) { double }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::DogmaAttributes,
          not_modified?: false,
          etag: new_etag,
          response: response)
      end

      before do
        expect(EveOnline::ESI::DogmaAttributes).to receive(:new)
          .and_return(esi)
      end

      before do
        expect(subject).to receive(:etag)
          .and_return(etag)
          .twice
      end

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_dogma_attributes) }

      before { expect(subject).to receive(:remove_old_dogma_attributes) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
          etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:esi) do
        instance_double(EveOnline::ESI::DogmaAttributes,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::DogmaAttributes).to receive(:new)
          .and_return(esi)
      end

      before { expect(subject).to receive(:etag).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:import_new_dogma_attributes) }

      before { expect(subject).not_to receive(:remove_old_dogma_attributes) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#etag" do
    context "when @etag set" do
      let(:etag) { instance_double(Eve::Etag) }

      before { subject.instance_variable_set(:@etag, etag) }

      specify { expect(subject.send(:etag)).to eq(etag) }
    end

    context "when @etag not set" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::DogmaAttributes,
          url: url)
      end

      let(:etag) { instance_double(Eve::Etag) }

      before do
        expect(EveOnline::ESI::DogmaAttributes).to receive(:new)
          .and_return(esi)
      end

      before do
        expect(Eve::Etag).to receive(:find_or_initialize_by)
          .with(url: url)
          .and_return(etag)
      end

      specify { expect { subject.send(:etag) }.not_to raise_error }

      specify { expect { subject.send(:etag) }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end

  describe "#import_new_dogma_attributes" do
    let(:eve_dogma_attribute_ids) { double }

    before { expect(Eve::DogmaAttribute).to receive(:pluck).with(:attribute_id).and_return(eve_dogma_attribute_ids) }

    let(:attribute_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::DogmaAttributes,
        attribute_ids: attribute_ids)
    end

    before { expect(EveOnline::ESI::DogmaAttributes).to receive(:new).and_return(esi) }

    let(:attribute_id) { double }

    let(:attribute_ids_to_create) { [attribute_id] }

    before { expect(attribute_ids).to receive(:-).with(eve_dogma_attribute_ids).and_return(attribute_ids_to_create) }

    before { expect(Eve::UpdateDogmaAttributeJob).to receive(:perform_later).with(attribute_id) }

    specify { expect { subject.send(:import_new_dogma_attributes) }.not_to raise_error }
  end

  describe "#remove_old_dogma_attributes" do
    let(:eve_dogma_attribute_ids) { double }

    before { expect(Eve::DogmaAttribute).to receive(:pluck).with(:attribute_id).and_return(eve_dogma_attribute_ids) }

    let(:attribute_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::DogmaAttributes,
        attribute_ids: attribute_ids)
    end

    before { expect(EveOnline::ESI::DogmaAttributes).to receive(:new).and_return(esi) }

    let(:eve_dogma_attribute_id_to_remove) { double }

    let(:eve_dogma_attribute_ids_to_remove) { [eve_dogma_attribute_id_to_remove] }

    before { expect(eve_dogma_attribute_ids).to receive(:-).with(attribute_ids).and_return(eve_dogma_attribute_ids_to_remove) }

    let(:attribute_id) { double }

    let(:dogma_attribute) { instance_double(Eve::DogmaAttribute, attribute_id: attribute_id) }

    before { expect(Eve::DogmaAttribute).to receive(:find_or_initialize_by).with(attribute_id: eve_dogma_attribute_id_to_remove).and_return(dogma_attribute) }

    before { expect(dogma_attribute).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_dogma_attributes) }.not_to raise_error }
  end
end
