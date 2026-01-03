# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::SitemapUpdaterTask do
  describe "#process" do
    before { expect(SitemapUpdaterJob).to receive(:perform_later) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
