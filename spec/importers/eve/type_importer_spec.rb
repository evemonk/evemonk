# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeImporter do
  let(:type_id) { double }

  subject { described_class.new(type_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:type_id) { should eq(type_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(type_id, locale) }

      its(:type_id) { should eq(type_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_type) { instance_double(Eve::Type) }

    before { expect(Eve::Type).to receive(:find_or_initialize_by).with(type_id: type_id).and_return(eve_type) }

    context "when eve type found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseType, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_type).to receive(:update!).with(json) }

      before { expect(subject).to receive(:import_type_dogma_attributes).with(eve_type) }

      before { expect(subject).to receive(:import_type_dogma_effects).with(eve_type) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve type not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Type ID #{type_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Type ID #{type_id}")
          end
        end
      end

      before { expect(eve_type).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseType) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseType) }

      before { expect(EveOnline::ESI::UniverseType).to receive(:new).with(id: type_id, language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_type_dogma_attributes" do
    context "when locale is :en" do
      let(:locale) { :en }

      subject { described_class.new(type_id, locale) }

      let(:eve_type) { instance_double(Eve::Type) }

      let(:dogma_attribute_json) { double }

      let(:dogma_attribute) { instance_double(EveOnline::ESI::Models::DogmaAttributeShort, as_json: dogma_attribute_json) }

      let(:dogma_attributes) { [dogma_attribute] }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseType,
          dogma_attributes: dogma_attributes)
      end

      before { expect(subject).to receive(:esi).and_return(esi) }

      before do
        #
        # eve_type.type_dogma_attributes.destroy_all
        #
        expect(eve_type).to receive(:type_dogma_attributes) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      before do
        #
        # eve_type.type_dogma_attributes.create!(dogma_attribute.as_json)
        #
        expect(eve_type).to receive(:type_dogma_attributes) do
          double.tap do |a|
            expect(a).to receive(:create!).with(dogma_attribute_json)
          end
        end
      end

      specify { expect { subject.send(:import_type_dogma_attributes, eve_type) }.not_to raise_error }
    end

    context "when locale is not :en" do
      let(:locale) { :ru }

      subject { described_class.new(type_id, locale) }

      let(:eve_type) { instance_double(Eve::Type) }

      specify { expect { subject.send(:import_type_dogma_attributes, eve_type) }.not_to raise_error }
    end
  end

  describe "#import_type_dogma_effects" do
    context "when locale is :en" do
      let(:locale) { :en }

      subject { described_class.new(type_id, locale) }

      let(:eve_type) { instance_double(Eve::Type) }

      let(:dogma_effect_json) { double }

      let(:dogma_effect) { instance_double(EveOnline::ESI::Models::DogmaEffectShort, as_json: dogma_effect_json) }

      let(:dogma_effects) { [dogma_effect] }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseType,
          dogma_effects: dogma_effects)
      end

      before { expect(subject).to receive(:esi).and_return(esi) }

      before do
        #
        # eve_type.type_dogma_effects.destroy_all
        #
        expect(eve_type).to receive(:type_dogma_effects) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      before do
        #
        # eve_type.type_dogma_effects.create!(dogma_effect.as_json)
        #
        expect(eve_type).to receive(:type_dogma_effects) do
          double.tap do |a|
            expect(a).to receive(:create!).with(dogma_effect_json)
          end
        end
      end

      specify { expect { subject.send(:import_type_dogma_effects, eve_type) }.not_to raise_error }
    end

    context "when locale is not :en" do
      let(:locale) { :ru }

      subject { described_class.new(type_id, locale) }

      let(:eve_type) { instance_double(Eve::Type) }

      specify { expect { subject.send(:import_type_dogma_effects, eve_type) }.not_to raise_error }
    end
  end
end
