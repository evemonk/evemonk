# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::SitemapUpdaterTask do
  describe "#process" do
    before { expect(SitemapUpdaterJob).to receive(:perform_now) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
