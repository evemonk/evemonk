# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttributeImporter do
  let(:attribute_id) { double }

  subject { described_class.new(attribute_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:attribute_id) { should eq(attribute_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_dogma_attribute) { instance_double(Eve::DogmaAttribute) }

    before { expect(Eve::DogmaAttribute).to receive(:find_or_initialize_by).with(attribute_id: attribute_id).and_return(eve_dogma_attribute) }

    context "when eve dogma attribute found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::DogmaAttribute, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_dogma_attribute).to receive(:update!).with(json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve dogma attribute not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve DogmaAttribute ID #{attribute_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve DogmaAttribute ID #{attribute_id}")
          end
        end
      end

      before { expect(eve_dogma_attribute).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::DogmaAttribute) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::DogmaAttribute) }

      before { expect(EveOnline::ESI::DogmaAttribute).to receive(:new).with(id: attribute_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
