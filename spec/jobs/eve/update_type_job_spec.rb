# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateTypeJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:type_id) { double }

    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::TypeImporter.new(type_id, locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::TypeImporter).to receive(:new).with(type_id, locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform(type_id) }.not_to raise_error }
  end
end
