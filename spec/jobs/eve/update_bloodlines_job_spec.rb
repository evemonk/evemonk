# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateBloodlinesJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::BloodlinesImporter.new(locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::BloodlinesImporter).to receive(:new).with(locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
