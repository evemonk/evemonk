# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateFactionsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when jobs eve factions enabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:factions] = true }

      before do
        #
        # LanguageMapper::LANGUAGES.each_key do |locale|
        #   Eve::FactionsImporter.new(locale).import
        # end
        #
        LanguageMapper::LANGUAGES.each_key do |locale|
          expect(Eve::FactionsImporter).to receive(:new).with(locale) do
            double.tap do |a|
              expect(a).to receive(:import)
            end
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when jobs eve factions disabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:factions] = false }

      before { expect(Eve::FactionsImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
