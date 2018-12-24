# frozen_string_literal: true

require 'rails_helper'

describe Eve::CorporationImporter do
  describe '#import' do
    context 'when import ok' do
      let(:corporation_id) { double }

      subject { described_class.new(corporation_id) }

      before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

      let(:json) { double }

      let(:corporation) { instance_double(EveOnline::ESI::Corporation, as_json: json) }

      before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id).and_return(corporation) }

      before { expect(eve_corporation).to receive(:assign_attributes).with(json) }

      context 'when corporation changed' do
        let(:eve_corporation) { instance_double(Eve::Corporation, changed?: true) }

        before { expect(eve_corporation).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when corporation not changed' do
        let(:eve_corporation) { instance_double(Eve::Corporation, changed?: false) }

        before { expect(eve_corporation).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when corporation not found' do
      let(:corporation_id) { double }

      subject { described_class.new(corporation_id) }

      before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

      before { expect(EveOnline::ESI::Corporation).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      context 'when corporation persisted' do
        let(:eve_corporation) { instance_double(Eve::Corporation, persisted?: true) }

        before { expect(eve_corporation).to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when corporation not persisted' do
        let(:eve_corporation) { instance_double(Eve::Corporation, persisted?: false) }

        before { expect(eve_corporation).not_to receive(:destroy) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end
end
