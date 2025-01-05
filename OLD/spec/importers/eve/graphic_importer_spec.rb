# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GraphicImporter do
  let(:graphic_id) { double }

  subject { described_class.new(graphic_id) }

  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_graphic) { instance_double(Eve::Graphic) }

    before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(id: graphic_id).and_return(eve_graphic) }

    context "when eve graphic found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphic, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      let(:transformed_json) { double }

      before { expect(json).to receive(:transform_keys).with(graphic_id: :id).and_return(transformed_json) }

      before { expect(eve_graphic).to receive(:update!).with(transformed_json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve graphic not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Graphic ID #{graphic_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Graphic ID #{graphic_id}")
          end
        end
      end

      before { expect(eve_graphic).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
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
