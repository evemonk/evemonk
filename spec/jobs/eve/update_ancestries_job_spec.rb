# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateAncestriesJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::AncestriesImporter.new(locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::AncestriesImporter).to receive(:new).with(locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    subject { described_class.new }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
