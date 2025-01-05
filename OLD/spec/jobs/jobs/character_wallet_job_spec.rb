# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterWalletJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    let(:character_id) { double }

    context "when jobs character wallet_job enabled" do
      before { Rails.configuration.evemonk.jobs[:character][:wallet_job] = true }

      before do
        #
        # CharacterWalletImporter.new(character_id).import
        #
        expect(CharacterWalletImporter).to receive(:new).with(character_id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(character_id) }.not_to raise_error }
    end

    context "when jobs character wallet_job disabled" do
      before { Rails.configuration.evemonk.jobs[:character][:wallet_job] = false }

      before { expect(CharacterWalletImporter).not_to receive(:new) }

      specify { expect { subject.perform(character_id) }.not_to raise_error }
    end
  end
end
