# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttributesImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::DogmaAttributes, not_modified?: true) }

      before { expect(EveOnline::ESI::DogmaAttributes).to receive(:new).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:esi) { instance_double(EveOnline::ESI::DogmaAttributes, not_modified?: false) }

      before { expect(EveOnline::ESI::DogmaAttributes).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:import_new_dogma_attributes) }

      before { expect(subject).to receive(:remove_old_dogma_attributes) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::DogmaAttributes) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::DogmaAttributes) }

      before { expect(EveOnline::ESI::DogmaAttributes).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_dogma_attributes" do
    let(:eve_dogma_attribute_ids) { double }

    before { expect(Eve::DogmaAttribute).to receive(:pluck).with(:attribute_id).and_return(eve_dogma_attribute_ids) }

    let(:attribute_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::DogmaAttributes,
        attribute_ids: attribute_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

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

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_dogma_attribute_id_to_remove) { double }

    let(:eve_dogma_attribute_ids_to_remove) { [eve_dogma_attribute_id_to_remove] }

    before { expect(eve_dogma_attribute_ids).to receive(:-).with(attribute_ids).and_return(eve_dogma_attribute_ids_to_remove) }

    let(:attribute_id) { double }

    let(:dogma_attribute) { instance_double(Eve::DogmaAttribute, attribute_id: attribute_id) }

    before { expect(Eve::DogmaAttribute).to receive(:find_or_initialize_by).with({attribute_id: eve_dogma_attribute_id_to_remove}).and_return(dogma_attribute) }

    before { expect(dogma_attribute).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_dogma_attributes) }.not_to raise_error }
  end
end
