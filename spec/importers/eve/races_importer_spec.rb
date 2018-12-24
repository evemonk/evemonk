# frozen_string_literal: true

require 'rails_helper'

describe Eve::RacesImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("races:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("races:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:race_id) { double }

      let(:as_json) { double }

      let(:race) { instance_double(EveOnline::ESI::Models::Race, race_id: race_id, as_json: as_json) }

      let(:eveonline_esi_races) do
        instance_double(EveOnline::ESI::UniverseRaces,
                        not_modified?: false,
                        etag: new_etag,
                        races: [race])
      end

      let(:new_etag) { double }

      before { expect(EveOnline::ESI::UniverseRaces).to receive(:new).and_return(eveonline_esi_races) }

      before { expect(Eve::Race).to receive(:find_or_initialize_by).with(race_id: race_id).and_return(eve_race) }

      before { expect(eve_race).to receive(:assign_attributes).with(as_json) }

      before do
        #
        # Redis.current.set("races:#{ I18n.locale }:etag", eveonline_esi_alliances.etag)
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:set).with("races:#{ I18n.locale }:etag", new_etag)
          end
        end
      end

      context 'when race changed' do
        let(:eve_race) { instance_double(Eve::Race, changed?: true) }

        before { expect(eve_race).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when race not changed' do
        let(:eve_race) { instance_double(Eve::Race, changed?: false) }

        before { expect(eve_race).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when no fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("races:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("races:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:eveonline_esi_races) do
        instance_double(EveOnline::ESI::UniverseRaces,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseRaces).to receive(:new).with(etag: current_etag).and_return(eveonline_esi_races) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
