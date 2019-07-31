# frozen_string_literal: true

require "rails_helper"

describe SitemapUpdaterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    before do
      #
      # Sitemap::Updater.new.update
      #
      expect(Sitemap::Updater).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:update)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
