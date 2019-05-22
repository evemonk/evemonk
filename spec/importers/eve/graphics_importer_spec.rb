# frozen_string_literal: true

require 'rails_helper'

describe Eve::GraphicsImporter do
  describe '#initialize' do
    let(:esi) { instance_double(EveOnline::ESI::UniverseGraphics) }

    before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

    its(:esi) { should eq(esi) }
  end

  # private methods

  describe '#etag' do
    context 'when @etag set' do
      let(:etag) { instance_double(Etag) }

      before { subject.instance_variable_set(:@etag, etag) }

      specify { expect(subject.send(:etag)).to eq(etag) }
    end

    context 'when @etag not set' do
      let(:url) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseGraphics, url: url) }

      let(:etag) { instance_double(Etag) }

      before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      specify { expect { subject.send(:etag) }.not_to raise_error }

      specify { expect { subject.send(:etag) }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end



    # describe '#import' do
  #   context 'when fresh data available' do
  #     let(:url) { double }
  #
  #     let(:new_etag) { double }
  #
  #     let(:graphic_id) { double }
  #
  #     let(:esi) do
  #       instance_double(EveOnline::ESI::UniverseGraphics,
  #                       not_modified?: false,
  #                       url: url,
  #                       etag: new_etag,
  #                       graphic_ids: [graphic_id])
  #     end
  #
  #     before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }
  #
  #     let(:etag) { instance_double(Etag, etag: 'e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b') }
  #
  #     before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }
  #
  #     before { expect(esi).to receive(:etag=).with('e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b') }
  #
  #     before { expect(Eve::GraphicImporterWorker).to receive(:perform_async).with(graphic_id) }
  #
  #     before { expect(etag).to receive(:update!).with(etag: new_etag) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  #
  #   context 'when no fresh data available' do
  #     let(:url) { double }
  #
  #     let(:esi) do
  #       instance_double(EveOnline::ESI::UniverseGraphics,
  #                       not_modified?: true,
  #                       url: url)
  #     end
  #
  #     before { expect(EveOnline::ESI::UniverseGraphics).to receive(:new).and_return(esi) }
  #
  #     let(:etag) { instance_double(Etag, etag: 'e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b') }
  #
  #     before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }
  #
  #     before { expect(esi).to receive(:etag=).with('e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b') }
  #
  #     before { expect(Eve::GraphicImporterWorker).not_to receive(:perform_async) }
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  # end
end
