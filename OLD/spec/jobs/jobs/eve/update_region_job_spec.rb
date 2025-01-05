# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateRegionJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:region_id) { double }

    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::RegionImporter.new(region_id, locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::RegionImporter).to receive(:new).with(region_id, locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform(region_id) }.not_to raise_error }
  end
end
