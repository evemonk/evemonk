# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalGroupsImporter do
  describe "#import" do
    let(:group_id) { double }

    before do
      #
      # Eve::Group.pluck(:group_id) => [group_id]
      #
      expect(Eve::Group).to receive(:pluck).with(:group_id).and_return([group_id])
    end

    before { expect(Eve::UpdateGroupJob).to receive(:perform_later).with(group_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
