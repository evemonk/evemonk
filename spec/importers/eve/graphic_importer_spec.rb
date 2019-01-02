# frozen_string_literal: true

require 'rails_helper'

describe Eve::GraphicImporter do
  # describe '#import' do
  #   context 'when import ok' do
  #     let(:graphic_id) { double }

  #     subject { described_class.new(graphic_id) }

  #     before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

  #     let(:json) { double }

  #     let(:graphic) { instance_double(EveOnline::ESI::UniverseGraphic, as_json: json) }

  #     before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).with(id: graphic_id).and_return(graphic) }

  #     before { expect(eve_graphic).to receive(:assign_attributes).with(json) }

  #     context 'when graphic changed' do
  #       let(:eve_graphic) { instance_double(Eve::Graphic, changed?: true) }

  #       before { expect(eve_graphic).to receive(:save!) }

  #       specify { expect { subject.import }.not_to raise_error }
  #     end

  #     context 'when graphic not changed' do
  #       let(:eve_graphic) { instance_double(Eve::Graphic, changed?: false) }

  #       before { expect(eve_graphic).not_to receive(:save!) }

  #       specify { expect { subject.import }.not_to raise_error }
  #     end
  #   end

  #   context 'when graphic not found' do
  #     let(:graphic_id) { double }

  #     subject { described_class.new(graphic_id) }

  #     before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

  #     before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

  #     context 'when graphic persisted' do
  #       let(:eve_graphic) { instance_double(Eve::Graphic, persisted?: true) }

  #       before { expect(eve_graphic).to receive(:destroy) }

  #       specify { expect { subject.import }.not_to raise_error }
  #     end

  #     context 'when graphic not persisted' do
  #       let(:eve_graphic) { instance_double(Eve::Graphic, persisted?: false) }

  #       before { expect(eve_graphic).not_to receive(:destroy) }

  #       specify { expect { subject.import }.not_to raise_error }
  #     end
  #   end
  # end

  describe '#import' do
    context 'when fresh data available' do
      # context 'when alliance found' do
      #   let(:alliance_id) { double }

      #   subject { described_class.new(alliance_id) }

      #   let(:eve_alliance) { instance_double(Eve::Alliance) }

      #   before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

      #   let(:json) { double }

      #   let(:url) { double }

      #   let(:new_etag) { double }

      #   let(:eveonline_esi_alliance) do
      #     instance_double(EveOnline::ESI::Alliance,
      #                     url: url,
      #                     not_modified?: false,
      #                     etag: new_etag,
      #                     as_json: json)
      #   end

      #   before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(eveonline_esi_alliance) }

      #   let(:etag) { instance_double(Etag, etag: '6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2') }

      #   before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      #   before { expect(eveonline_esi_alliance).to receive(:etag=).with('6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2') }

      #   before { expect(eve_alliance).to receive(:update!).with(json) }

      #   before { expect(etag).to receive(:update!).with(etag: new_etag) }

      #   specify { expect { subject.import }.not_to raise_error }
      # end

      # context 'when graphic not found' do
      #   let(:graphic_id) { double }

      #   subject { described_class.new(graphic_id) }

      #   let(:eve_alliance) { instance_double(Eve::Alliance) }

      #   before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

      #   before { expect(EveOnline::ESI::Alliance).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      #   before { expect(eve_alliance).to receive(:destroy!) }

      #   specify { expect { subject.import }.not_to raise_error }
      # end
    end

    context 'when no fresh data available' do
      let(:graphic_id) { double }

      subject { described_class.new(graphic_id) }

      let(:eve_graphic) { instance_double(Eve::Graphic) }

      before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

      let(:url) { double }

      let(:eveonline_esi_graphic) do
        instance_double(EveOnline::ESI::Alliance,
                        url: url,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).with(graphic_id: graphic_id).and_return(eveonline_esi_graphic) }

      let(:etag) { instance_double(Etag, etag: 'e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b') }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(eveonline_esi_graphic).to receive(:etag=).with('e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b') }

      before { expect(eve_graphic).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
