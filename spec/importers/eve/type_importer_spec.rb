# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeImporter do
  describe "#initialize" do
    context "without locale" do
      let(:type_id) { double }

      subject { described_class.new(type_id) }

      its(:type_id) { should eq(type_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:type_id) { double }

      let(:locale) { :ru }

      subject { described_class.new(type_id, locale) }

      its(:type_id) { should eq(type_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#initialize" do
    let(:type_id) { double }

    subject { described_class.new(type_id) }

    its(:type_id) { should eq(type_id) }
  end

  describe "#import" do
    context "when fresh data available" do
      context "when type found" do
        let(:type_id) { double }

        subject { described_class.new(type_id) }

        let(:eve_type) { instance_double(Eve::Type) }

        before { expect(Eve::Type).to receive(:find_or_initialize_by).with(type_id: type_id).and_return(eve_type) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:dogma_attribute_json) { double }

        let(:dogma_attribute) { instance_double(EveOnline::ESI::Models::DogmaAttributeShort, as_json: dogma_attribute_json) }

        let(:dogma_attributes) { [dogma_attribute] }

        let(:dogma_effect_json) { double }

        let(:dogma_effect) { instance_double(EveOnline::ESI::Models::DogmaEffectShort, as_json: dogma_effect_json) }

        let(:dogma_effects) { [dogma_effect] }

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseType,
            url: url,
            not_modified?: false,
            etag: new_etag,
            dogma_attributes: dogma_attributes,
            dogma_effects: dogma_effects,
            response: response,
            as_json: json)
        end

        before { expect(EveOnline::ESI::UniverseType).to receive(:new).with(id: type_id, language: "en-us").and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_type).to receive(:update!).with(json) }

        before { expect(subject).to receive(:import_type_dogma_attributes).with(esi, eve_type) }

        before { expect(subject).to receive(:import_type_dogma_effects).with(esi, eve_type) }

        # before do
        #   #
        #   # eve_type.type_dogma_attributes.destroy_all
        #   #
        #   expect(eve_type).to receive(:type_dogma_attributes) do
        #     double.tap do |a|
        #       expect(a).to receive(:destroy_all)
        #     end
        #   end
        # end

        # before do
        #   #
        #   # eve_type.type_dogma_effects.destroy_all
        #   #
        #   expect(eve_type).to receive(:type_dogma_effects) do
        #     double.tap do |a|
        #       expect(a).to receive(:destroy_all)
        #     end
        #   end
        # end

        # before do
        #   #
        #   # eve_type.type_dogma_attributes.create!(dogma_attribute.as_json)
        #   #
        #   expect(eve_type).to receive(:type_dogma_attributes) do
        #     double.tap do |a|
        #       expect(a).to receive(:create!).with(dogma_attribute_json)
        #     end
        #   end
        # end

        # before do
        #   #
        #   # eve_type.type_dogma_effects.create!(dogma_effect.as_json)
        #   #
        #   expect(eve_type).to receive(:type_dogma_effects) do
        #     double.tap do |a|
        #       expect(a).to receive(:create!).with(dogma_effect_json)
        #     end
        #   end
        # end

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when type not found" do
        let(:type_id) { double }

        subject { described_class.new(type_id) }

        let(:eve_type) { instance_double(Eve::Type) }

        before { expect(Eve::Type).to receive(:find_or_initialize_by).with(type_id: type_id).and_return(eve_type) }

        before { expect(EveOnline::ESI::UniverseType).to receive(:new).with(id: type_id, language: "en-us").and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_type).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:type_id) { double }

      subject { described_class.new(type_id) }

      let(:eve_type) { instance_double(Eve::Type) }

      before { expect(Eve::Type).to receive(:find_or_initialize_by).with(type_id: type_id).and_return(eve_type) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseType,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseType).to receive(:new).with(id: type_id, language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_type).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  # describe "#import_type_dogma_attributes" do
  #   context "when locale is :en" do
  #     let(:eve_type) { instance_double(Eve::Type) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  #
  #   context "when locale is not :en" do
  #   end
  # end
  #
  # describe "#import_type_dogma_effects" do
  #   context "when locale is :en" do
  #     let(:eve_type) { instance_double(Eve::Type) }
  #   end
  #
  #   context "when locale is not :en" do
  #   end
  # end
end
