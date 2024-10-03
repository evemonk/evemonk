# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateGroupsJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:page) { double }

    before do
      #
      # Eve::GroupsImporter.new(page).import
      #
      expect(Eve::GroupsImporter).to receive(:new).with(page) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(page) }.not_to raise_error }
  end
end
