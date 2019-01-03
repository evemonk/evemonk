# frozen_string_literal: true

describe Eve::AllianceCorporationsImporter do
  describe '#import' do
    let(:alliance_id) { double }

    subject { described_class.new(alliance_id) }

    context 'when import ok' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: alliance_id).and_return(eve_alliance) }

      let(:remote_corporation_id) { double }

      let(:remote_corporation_ids) { [remote_corporation_id] }

      let(:eveonline_esi_alliance_corporations) { instance_double(EveOnline::ESI::AllianceCorporations, corporation_ids: remote_corporation_ids) }

      before { expect(EveOnline::ESI::AllianceCorporations).to receive(:new).with(alliance_id: alliance_id).and_return(eveonline_esi_alliance_corporations) }

      let(:local_corporation_id) { double }

      let(:local_corporation_ids) { [local_corporation_id] }

      before do
        expect(eve_alliance).to receive(:alliance_corporations) do
          double.tap do |a|
            expect(a).to receive(:pluck).with(:corporation_id).and_return(local_corporation_ids)
          end
        end
      end

      before do
        #
        # eve_alliance.alliance_corporations.create!(corporation_id: corporation_id)
        #
        expect(eve_alliance).to receive(:alliance_corporations) do
          double.tap do |a|
            expect(a).to receive(:create!).with(corporation_id: remote_corporation_id)
          end
        end
      end

      before do
        #
        # eve_alliance.alliance_corporations.where(corporation_id: corporation_id).destroy_all
        #
        expect(eve_alliance).to receive(:alliance_corporations) do
          double.tap do |a|
            expect(a).to receive(:where).with(corporation_id: local_corporation_id) do
              double.tap do |b|
                expect(b).to receive(:destroy_all)
              end
            end
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context 'when alliance not found' do
      before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: alliance_id).and_raise(ActiveRecord::RecordNotFound) }

      before do
        #
        # Rails.logger.info("Alliance with ID #{ alliance_id } not found")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("Alliance with ID #{ alliance_id } not found")
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
