# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterAssetsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    let(:id) { double }

    let(:page) { double }

    context "when jobs character assets enabled" do
      before { Rails.configuration.evemonk.jobs[:character][:assets] = true }

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

    context "when jobs character assets disabled" do
      before { Rails.configuration.evemonk.jobs[:character][:assets] = false }

      before { expect(CharacterAssetsImporter).not_to receive(:new) }

      specify { expect { subject.perform(id, page) }.not_to raise_error }
    end
  end
end
