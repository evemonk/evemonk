# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttributeImporter do
  describe "#initialize" do
    let(:attribute_id) { double }

    subject { described_class.new(attribute_id) }

    its(:attribute_id) { should eq(attribute_id) }
  end

  describe "#import" do
    context "when fresh data available" do
      context "when eve dogma attribute found" do
        let(:attribute_id) { double }

        subject { described_class.new(attribute_id) }

        let(:eve_dogma_attribute) { instance_double(Eve::DogmaAttribute) }

        before { expect(Eve::DogmaAttribute).to receive(:find_or_initialize_by).with(attribute_id: attribute_id).and_return(eve_dogma_attribute) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::DogmaAttribute,
            url: url,
            not_modified?: false,
            etag: new_etag,
            response: response,
            as_json: json)
        end

        before { expect(EveOnline::ESI::DogmaAttribute).to receive(:new).with(id: attribute_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_dogma_attribute).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when eve dogma attribute not found" do
        let(:attribute_id) { double }

        subject { described_class.new(attribute_id) }

        let(:eve_dogma_attribute) { instance_double(Eve::DogmaAttribute) }

        before { expect(Eve::DogmaAttribute).to receive(:find_or_initialize_by).with(attribute_id: attribute_id).and_return(eve_dogma_attribute) }

        before { expect(EveOnline::ESI::DogmaAttribute).to receive(:new).with(id: attribute_id).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_dogma_attribute).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:attribute_id) { double }

      subject { described_class.new(attribute_id) }

      let(:eve_dogma_attribute) { instance_double(Eve::DogmaAttribute) }

      before { expect(Eve::DogmaAttribute).to receive(:find_or_initialize_by).with(attribute_id: attribute_id).and_return(eve_dogma_attribute) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::DogmaAttribute,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::DogmaAttribute).to receive(:new).with(id: attribute_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_dogma_attribute).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
