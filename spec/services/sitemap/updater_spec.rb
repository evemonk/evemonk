# frozen_string_literal: true

require "rails_helper"

describe Sitemap::Updater do
  describe "#update" do
    before { expect(SitemapGenerator::Interpreter).to receive(:run).with({verbose: false}) }

    before { expect(SitemapGenerator::Sitemap).to receive(:ping_search_engines) }

    specify { expect { subject.update }.not_to raise_error }
  end
end
