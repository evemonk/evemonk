# frozen_string_literal: true

require "rails_helper"

describe Eve::GraphicsImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::UniverseGraphics) }

    before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      let(:new_etag) { double }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseGraphics,
          not_modified?: false,
          etag: new_etag,
          response: response)
      end

      before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:etag).and_return(etag).twice }

      before { expect(esi).to receive(:etag=).with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(subject).to receive(:import_new_graphics) }

      before { expect(subject).to receive(:remove_old_graphics) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseGraphics,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:etag).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(subject).not_to receive(:import_new_graphics) }

      before { expect(subject).not_to receive(:remove_old_graphics) }

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

      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphics, url: url) }

      let(:etag) { instance_double(Eve::Etag) }

      before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      specify { expect { subject.send(:etag) }.not_to raise_error }

      specify { expect { subject.send(:etag) }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end

  describe "#import_new_graphics" do
    let(:graphic_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseGraphics,
        graphic_ids: [graphic_id])
    end

    before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

    context "when graphic not imported" do
      before { expect(Eve::Graphic).to receive(:exists?).with(graphic_id: graphic_id).and_return(false) }

      before { expect(Eve::UpdateGraphicJob).to receive(:perform_later).with(graphic_id) }

      specify { expect { subject.send(:import_new_graphics) }.not_to raise_error }
    end

    context "when graphic already imported" do
      before { expect(Eve::Graphic).to receive(:exists?).with(graphic_id: graphic_id).and_return(true) }

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

    before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

    let(:eve_graphic_ids) { double }

    before { expect(Eve::Graphic).to receive(:pluck).with(:graphic_id).and_return(eve_graphic_ids) }

    let(:graphic_id_to_remove) { double }

    let(:graphic_ids_to_remove) { [graphic_id_to_remove] }

    before { expect(eve_graphic_ids).to receive(:-).with(graphic_ids).and_return(graphic_ids_to_remove) }

    let(:eve_graphic) { instance_double(Eve::Graphic) }

    before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id_to_remove).and_return(eve_graphic) }

    before { expect(eve_graphic).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_graphics) }.not_to raise_error }
  end
end
