# frozen_string_literal: true

require 'rails_helper'

describe Eve::CorporationImporter do
  describe '#import' do
    context 'when fresh data available' do
      context 'when corporation exists' do
        let(:corporation_id) { double }

        let(:etag) { double }

        subject { described_class.new(corporation_id) }

        before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

        let(:json) { double }

        let(:eveonline_esi_corporation) do
          instance_double(EveOnline::ESI::Corporation,
                          not_modified?: false,
                          as_json: json)
        end

        before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id, etag: etag).and_return(eveonline_esi_corporation) }

        before { expect(eve_corporation).to receive(:assign_attributes).with(json) }

        context 'when corporation is changed' do
          let(:eve_corporation) do
            instance_double(Eve::Corporation,
                            etag: etag,
                            changed?: true)
          end

          before { expect(eve_corporation).to receive(:save!) }

          specify { expect { subject.import }.not_to raise_error }
        end

        context 'when corporation not changed' do
          let(:eve_corporation) do
            instance_double(Eve::Corporation,
                            etag: etag,
                            changed?: false)
          end

          before { expect(eve_corporation).not_to receive(:save!) }

          specify { expect { subject.import }.not_to raise_error }
        end
      end

      context 'when corporation not found' do
        let(:corporation_id) { double }

        subject { described_class.new(corporation_id) }

        let(:etag) { double }

        before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

        before { expect(EveOnline::ESI::Corporation).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        context 'when corporation persisted' do
          let(:eve_corporation) do
            instance_double(Eve::Corporation,
                            persisted?: true,
                            etag: etag)
          end

          before { expect(eve_corporation).to receive(:destroy!) }

          specify { expect { subject.import }.not_to raise_error }
        end

        context 'when corporation not persisted' do
          let(:eve_corporation) do
            instance_double(Eve::Corporation,
                            persisted?: false,
                            etag: etag)
          end

          before { expect(eve_corporation).not_to receive(:destroy!) }

          specify { expect { subject.import }.not_to raise_error }
        end
      end
    end

    context 'when no fresh data available' do
      let(:corporation_id) { double }

      let(:etag) { double }

      subject { described_class.new(corporation_id) }

      let(:eve_corporation) { instance_double(Eve::Corporation, etag: etag) }

      before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

      let(:eveonline_esi_corporation) do
        instance_double(EveOnline::ESI::Corporation,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id, etag: etag).and_return(eveonline_esi_corporation) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
