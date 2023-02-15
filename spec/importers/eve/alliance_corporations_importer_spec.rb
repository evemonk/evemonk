# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceCorporationsImporter do
  let(:id) { double }

  subject { described_class.new(id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::AllianceCorporations) }

    its(:id) { should eq(id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    context "when eve alliance found" do
      before { expect(subject).to receive(:import_new_corporations) }

      before { expect(subject).to receive(:remove_old_corporations) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when ActiveRecord::RecordNotFound" do
      before { expect(subject).to receive(:import_new_corporations).and_raise(ActiveRecord::RecordNotFound) }

      before do
        #
        # Rails.logger.info("Alliance with ID #{id} not found")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("Alliance with ID #{id} not found")
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve alliance not found" do
      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before { expect(subject).to receive(:eve_alliance).and_return(eve_alliance) }

      before { expect(subject).to receive(:import_new_corporations).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before { expect(eve_alliance).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::AllianceCorporations) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::AllianceCorporations) }

      before { expect(EveOnline::ESI::AllianceCorporations).to receive(:new).with(alliance_id: id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_corporations" do
    let(:remote_corporation_id) { double }

    let(:remote_corporation_ids) { [remote_corporation_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::AllianceCorporations,
        corporation_ids: remote_corporation_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      expect(subject).to receive(:eve_alliance)
        .and_return(eve_alliance)
    end

    let(:local_corporation_id) { double }

    let(:local_corporation_ids) { [local_corporation_id] }

    before do
      #
      # eve_alliance.corporations.ids # => local_corporation_ids
      #
      expect(eve_alliance).to receive(:corporations) do
        double.tap do |a|
          expect(a).to receive(:ids).and_return(local_corporation_ids)
        end
      end
    end

    before do
      #
      # Eve::UpdateCorporationJob.perform_later(corporation_id)
      #
      expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(remote_corporation_id)
    end

    specify { expect { subject.send(:import_new_corporations) }.not_to raise_error }
  end

  describe "#remove_old_corporations" do
    let(:remote_corporation_id) { double }

    let(:remote_corporation_ids) { [remote_corporation_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::AllianceCorporations,
        corporation_ids: remote_corporation_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      expect(subject).to receive(:eve_alliance)
        .and_return(eve_alliance)
    end

    let(:local_corporation_id) { double }

    let(:local_corporation_ids) { [local_corporation_id] }

    before do
      #
      # eve_alliance.corporations.ids # => local_corporation_ids
      #
      expect(eve_alliance).to receive(:corporations) do
        double.tap do |a|
          expect(a).to receive(:ids).and_return(local_corporation_ids)
        end
      end
    end

    before do
      #
      # Eve::UpdateCorporationJob.perform_later(corporation_id)
      #
      expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(local_corporation_id)
    end

    specify { expect { subject.send(:remove_old_corporations) }.not_to raise_error }
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
        expect(Eve::Alliance).to receive(:find)
          .with(id)
          .and_return(eve_alliance)
      end

      specify { expect { subject.send(:eve_alliance) }.not_to raise_error }

      specify { expect { subject.send(:eve_alliance) }.to change { subject.instance_variable_get(:@eve_alliance) }.from(nil).to(eve_alliance) }
    end
  end
end
