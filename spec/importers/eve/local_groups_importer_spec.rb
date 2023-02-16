# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalGroupsImporter do
  describe "#import" do
    let(:id) { double }

    before do
      #
      # Eve::Group.ids # => [id]
      #
      expect(Eve::Group).to receive(:ids).and_return([id])
    end

    before { expect(Eve::UpdateGroupJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
