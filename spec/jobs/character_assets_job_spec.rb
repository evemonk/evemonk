# frozen_string_literal: true

require "rails_helper"

describe CharacterAssetsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    let(:id) { double }

    let(:page) { double }

    context "when character_assets_job enabled" do
      before { Flipper.enable(:character_assets_job) }

      before do
        #
        # CharacterAssetsImporter.new(id, page).import
        #
        expect(CharacterAssetsImporter).to receive(:new).with(id, page) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(id, page) }.not_to raise_error }
    end

    context "when character_assets_job disabled" do
      before { Flipper.disable(:character_assets_job) }

      before { expect(CharacterAssetsImporter).not_to receive(:new) }

      specify { expect { subject.perform(id, page) }.not_to raise_error }
    end
  end
end
