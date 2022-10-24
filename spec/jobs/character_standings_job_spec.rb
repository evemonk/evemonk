# frozen_string_literal: true

require "rails_helper"

describe CharacterStandingsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    let(:character_id) { double }

    context "when character_standings_job enabled" do
      before { Flipper.enable(:character_standings_job) }

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

    context "when character_standings_job disabled" do
      before { Flipper.disable(:character_job) }

      before { expect(CharacterStandingsImporter).not_to receive(:new) }

      specify { expect { subject.perform(character_id) }.not_to raise_error }
    end
  end
end
