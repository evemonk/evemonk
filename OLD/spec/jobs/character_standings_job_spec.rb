# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterStandingsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    let(:character_id) { double }

    context "when jobs character standings enabled" do
      before { Rails.configuration.evemonk.jobs[:character][:standings] = true }

      before do
        #
        # CharacterStandingsImporter.new(character_id).import
        #
        expect(CharacterStandingsImporter).to receive(:new).with(character_id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(character_id) }.not_to raise_error }
    end

    context "when jobs character standings disabled" do
      before { Rails.configuration.evemonk.jobs[:character][:standings] = false }

      before { expect(CharacterStandingsImporter).not_to receive(:new) }

      specify { expect { subject.perform(character_id) }.not_to raise_error }
    end
  end
end
