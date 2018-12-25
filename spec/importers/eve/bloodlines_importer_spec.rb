# frozen_string_literal: true

require 'rails_helper'

describe Eve::BloodlinesImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("bloodlines:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("bloodlines:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:bloodline_id) { double }

      let(:as_json) { double }

      let(:bloodline) { instance_double(EveOnline::ESI::Models::Bloodline, bloodline_id: bloodline_id, as_json: as_json) }

      let(:eveonline_esi_bloodlines) do
        instance_double(EveOnline::ESI::UniverseBloodlines,
                        not_modified?: false,
                        etag: new_etag,
                        bloodlines: [bloodline])
      end

      let(:new_etag) { double }

      before { expect(EveOnline::ESI::UniverseBloodlines).to receive(:new).and_return(eveonline_esi_bloodlines) }

      before { expect(Eve::Bloodline).to receive(:find_or_initialize_by).with(bloodline_id: bloodline_id).and_return(eve_bloodline) }

      before { expect(eve_bloodline).to receive(:assign_attributes).with(as_json) }

      before do
        #
        # Redis.current.set("bloodlines:#{ I18n.locale }:etag", eveonline_esi_factions.etag)
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:set).with("bloodlines:#{ I18n.locale }:etag", new_etag)
          end
        end
      end

      context 'when bloodline changed' do
        let(:eve_bloodline) { instance_double(Eve::Bloodline, changed?: true) }

        before { expect(eve_bloodline).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when bloodline not changed' do
        let(:eve_bloodline) { instance_double(Eve::Bloodline, changed?: false) }

        before { expect(eve_bloodline).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when no fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("bloodlines:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("bloodlines:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:eveonline_esi_bloodlines) do
        instance_double(EveOnline::ESI::UniverseBloodlines,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseBloodlines).to receive(:new).with(etag: current_etag).and_return(eveonline_esi_bloodlines) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
