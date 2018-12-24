# frozen_string_literal: true

require 'rails_helper'

describe Eve::AllianceImporter do
  describe '#import' do
    context 'when import ok' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

      let(:json) { double }

      let(:alliance) { instance_double(EveOnline::ESI::Alliance, as_json: json) }

      before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(alliance) }

      before { expect(eve_alliance).to receive(:assign_attributes).with(json) }

      context 'when alliance changed' do
        let(:eve_alliance) { instance_double(Eve::Alliance, changed?: true) }

        before { expect(eve_alliance).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when alliance not changed' do
        let(:eve_alliance) { instance_double(Eve::Alliance, changed?: false) }

        before { expect(eve_alliance).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when alliance not found' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

      before { expect(EveOnline::ESI::Alliance).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      context 'when alliance persisted' do
        let(:eve_alliance) { instance_double(Eve::Alliance, persisted?: true) }

        before { expect(eve_alliance).to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when alliance not persisted' do
        let(:eve_alliance) { instance_double(Eve::Alliance, persisted?: false) }

        before { expect(eve_alliance).not_to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end
end
