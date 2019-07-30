# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceCorporationsImporter do
  let(:alliance_id) { double }

  subject { described_class.new(alliance_id) }

  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::AllianceCorporations) }

    before do
      expect(EveOnline::ESI::AllianceCorporations).to receive(:new)
        .with(alliance_id: alliance_id)
        .and_return(esi)
    end

    its(:alliance_id) { should eq(alliance_id) }

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
                        etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:new_etag) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::AllianceCorporations,
                        not_modified?: false,
                        etag: new_etag)
      end

      before do
        expect(EveOnline::ESI::AllianceCorporations).to receive(:new)
          .with(alliance_id: alliance_id)
          .and_return(esi)
      end

      before do
        expect(subject).to receive(:etag)
          .and_return(etag)
          .twice
      end

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_corporations) }

      before { expect(subject).to receive(:remove_old_corporations) }

      before { expect(etag).to receive(:update!).with(etag: new_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
                        etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:esi) do
        instance_double(EveOnline::ESI::AllianceCorporations,
                        not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::AllianceCorporations).to receive(:new)
          .with(alliance_id: alliance_id)
          .and_return(esi)
      end

      before { expect(subject).to receive(:etag).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:import_new_corporations) }

      before { expect(subject).not_to receive(:remove_old_corporations) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when alliance not found" do
      before do
        expect(subject).to receive(:etag)
          .and_raise(ActiveRecord::RecordNotFound)
      end

      before do
        #
        # Rails.logger.info("Alliance with ID #{ alliance_id } not found")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info)
              .with("Alliance with ID #{alliance_id} not found")
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_new_corporations" do
    let(:remote_corporation_id) { double }

    let(:remote_corporation_ids) { [remote_corporation_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::AllianceCorporations,
                      not_modified?: false,
                      corporation_ids: remote_corporation_ids)
    end

    before do
      expect(EveOnline::ESI::AllianceCorporations).to receive(:new)
        .with(alliance_id: alliance_id)
        .and_return(esi)
    end

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      expect(subject).to receive(:eve_alliance)
        .and_return(eve_alliance)
        .twice
    end

    let(:local_corporation_id) { double }

    let(:local_corporation_ids) { [local_corporation_id] }

    before do
      #
      # eve_alliance.alliance_corporations.pluck(:corporation_id)
      #
      expect(eve_alliance).to receive(:alliance_corporations) do
        double.tap do |a|
          expect(a).to receive(:pluck).with(:corporation_id)
            .and_return(local_corporation_ids)
        end
      end
    end

    before do
      #
      # eve_alliance.alliance_corporations.create!(corporation_id: corporation_id)
      #
      expect(eve_alliance).to receive(:alliance_corporations) do
        double.tap do |a|
          expect(a).to receive(:create!)
            .with(corporation_id: remote_corporation_id)
        end
      end
    end

    specify { expect { subject.send(:import_new_corporations) }.not_to raise_error }
  end

  describe "#remove_old_corporations" do
    let(:remote_corporation_id) { double }

    let(:remote_corporation_ids) { [remote_corporation_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::AllianceCorporations,
                      not_modified?: false,
                      corporation_ids: remote_corporation_ids)
    end

    before do
      expect(EveOnline::ESI::AllianceCorporations).to receive(:new)
        .with(alliance_id: alliance_id)
        .and_return(esi)
    end

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      expect(subject).to receive(:eve_alliance)
        .and_return(eve_alliance)
        .twice
    end

    let(:local_corporation_id) { double }

    let(:local_corporation_ids) { [local_corporation_id] }

    before do
      #
      # eve_alliance.alliance_corporations.pluck(:corporation_id)
      #
      expect(eve_alliance).to receive(:alliance_corporations) do
        double.tap do |a|
          expect(a).to receive(:pluck)
            .with(:corporation_id)
            .and_return(local_corporation_ids)
        end
      end
    end

    before do
      #
      # eve_alliance.alliance_corporations.where(corporation_id: corporation_ids).destroy_all
      #
      expect(eve_alliance).to receive(:alliance_corporations) do
        double.tap do |a|
          expect(a).to receive(:where).with(corporation_id: local_corporation_ids) do
            double.tap do |b|
              expect(b).to receive(:destroy_all)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:remove_old_corporations) }.not_to raise_error }
  end

  describe "#etag" do
    context "when @etag set" do
      let(:etag) { instance_double(Eve::Etag) }

      before { subject.instance_variable_set(:@etag, etag) }

      specify { expect(subject.send(:etag)).to eq(etag) }
    end

    context "when @etag not set" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::AllianceCorporations,
                        url: url)
      end

      let(:etag) { instance_double(Eve::Etag) }

      before do
        expect(EveOnline::ESI::AllianceCorporations).to receive(:new)
          .with(alliance_id: alliance_id)
          .and_return(esi)
      end

      before do
        expect(Eve::Etag).to receive(:find_or_initialize_by)
          .with(url: url)
          .and_return(etag)
      end

      specify { expect { subject.send(:etag) }.not_to raise_error }

      specify { expect { subject.send(:etag) }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end

  describe "#eve_alliance" do
    context "when @eve_alliance set" do
      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before { subject.instance_variable_set(:@eve_alliance, eve_alliance) }

      specify { expect(subject.send(:eve_alliance)).to eq(eve_alliance) }
    end

    context "when @eve_alliance not set" do
      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before do
        expect(Eve::Alliance).to receive(:find_by!)
          .with(alliance_id: alliance_id)
          .and_return(eve_alliance)
      end

      specify { expect { subject.send(:eve_alliance) }.not_to raise_error }

      specify { expect { subject.send(:eve_alliance) }.to change { subject.instance_variable_get(:@eve_alliance) }.from(nil).to(eve_alliance) }
    end
  end
end
