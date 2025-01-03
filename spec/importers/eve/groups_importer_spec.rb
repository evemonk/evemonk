# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GroupsImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when page is first" do
      before { VCR.insert_cassette "esi/universe/groups" }

      after { VCR.eject_cassette }

      specify do
        subject.import

        expect(Eve::UpdateGroupJob).to have_been_enqueued.exactly(1000).times

        expect(Eve::UpdateGroupsJob).to have_been_enqueued.exactly(1).times.with(2)
      end
    end
  end
end
