# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateCharacterJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { 1 }

    context "when eve character is enabled" do
      before { Flipper.enable(:eve_character) }

      after { Flipper.disable(:eve_character) }

      before do
        #
        # Eve::CharacterImporter.new(id).import
        #
        expect(Eve::CharacterImporter).to receive(:new).with(id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(id) }.not_to raise_error }
    end

    context "when eve character is disabled" do
      before { expect(Eve::CharacterImporter).not_to receive(:new) }

      specify { expect { subject.perform(id) }.not_to raise_error }
    end
  end
end
