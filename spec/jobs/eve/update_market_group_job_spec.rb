# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateMarketGroupJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:market_group_id) { double }

    before do
      #
      # LanguageMapper::LANGUAGES.each_key do |locale|
      #   Eve::MarketGroupImporter.new(market_group_id, locale).import
      # end
      #
      LanguageMapper::LANGUAGES.each_key do |locale|
        expect(Eve::MarketGroupImporter).to receive(:new).with(market_group_id, locale) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end
    end

    specify { expect { subject.perform(market_group_id) }.not_to raise_error }
  end
end
