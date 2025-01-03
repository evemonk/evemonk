# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GroupsImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when page is first" do
      before { VCR.insert_cassette "esi/universe/groups" }

      before { clear_enqueued_jobs }

      after { VCR.eject_cassette }

      specify do
        subject.import

        expect(Eve::UpdateGroupJob).to have_been_enqueued.exactly(1000).times

        expect(Eve::UpdateGroupsJob).to have_been_enqueued.exactly(1).times.with(2)
      end
    end

    context "when page is last" do
      let(:page) { 2 }

      subject { described_class.new(page) }

      before { VCR.insert_cassette "esi/universe/groups_last_page" }

      before { clear_enqueued_jobs }

      after { VCR.eject_cassette }

      specify do
        subject.import

        expect(Eve::UpdateGroupJob).to have_been_enqueued.exactly(549).times

        expect(Eve::UpdateGroupsJob).not_to have_been_enqueued
      end
    end
  end
end
