# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateConstellationJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:constellation_id) { double }

    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::ConstellationImporter.new(constellation_id, locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::ConstellationImporter).to receive(:new).with(constellation_id, locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform(constellation_id) }.not_to raise_error }
  end
end
