# frozen_string_literal: true

require "rails_helper"

describe Eve::GraphicImporter do
  let(:graphic_id) { double }

  subject { described_class.new(graphic_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import!" do
    context "when eve graphic found" do
      let(:eve_graphic) { instance_double(Eve::Graphic) }

      before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

      let(:json) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseGraphic,
          as_json: json)
      end

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_graphic).to receive(:update!).with(json) }

      specify { expect { subject.import! }.not_to raise_error }
    end

    context "when eve graphic not found" do
      let(:eve_graphic) { instance_double(Eve::Graphic) }

      before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before { expect(eve_graphic).to receive(:destroy!) }

      specify { expect { subject.import! }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphic) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphic) }

      before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).with(id: graphic_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
