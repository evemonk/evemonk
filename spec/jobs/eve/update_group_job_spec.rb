# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateGroupJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:group_id) { double }

    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::GroupImporter.new(group_id, locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::GroupImporter).to receive(:new).with(group_id, locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform(group_id) }.not_to raise_error }
  end
end
