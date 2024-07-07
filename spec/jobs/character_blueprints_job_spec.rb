# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterBlueprintsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    let(:character_id) { double }

    let(:page) { double }

    before do
      #
      # CharacterBlueprintsImporter.new(character_id, page).import
      #
      expect(CharacterBlueprintsImporter).to receive(:new).with(character_id, page) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(character_id, page) }.not_to raise_error }
  end
end
