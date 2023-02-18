# frozen_string_literal: true

require "rails_helper"

describe Eve::GraphicsImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:import_new_graphics) }

    before { expect(subject).to receive(:remove_old_graphics) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphics) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphics) }

      before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_graphics" do
    let(:graphic_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseGraphics,
        graphic_ids: [graphic_id])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    context "when eve graphic not imported" do
      before { expect(Eve::Graphic).to receive(:exists?).with(id: graphic_id).and_return(false) }

      before { expect(Eve::UpdateGraphicJob).to receive(:perform_later).with(graphic_id) }

      specify { expect { subject.send(:import_new_graphics) }.not_to raise_error }
    end

    context "when eve graphic already imported" do
      before { expect(Eve::Graphic).to receive(:exists?).with(id: graphic_id).and_return(true) }

      before { expect(Eve::UpdateGraphicJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_new_graphics) }.not_to raise_error }
    end
  end

  describe "#remove_old_graphics" do
    let(:graphic_id) { double }

    let(:graphic_ids) { [graphic_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseGraphics,
        graphic_ids: graphic_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_graphic_ids) { double }

    before { expect(Eve::Graphic).to receive(:pluck).with(:id).and_return(eve_graphic_ids) }

    let(:graphic_id_to_remove) { double }

    let(:graphic_ids_to_remove) { [graphic_id_to_remove] }

    before { expect(eve_graphic_ids).to receive(:-).with(graphic_ids).and_return(graphic_ids_to_remove) }

    let(:eve_graphic) { instance_double(Eve::Graphic) }

    before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(id: graphic_id_to_remove).and_return(eve_graphic) }

    before { expect(eve_graphic).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_graphics) }.not_to raise_error }
  end
end
