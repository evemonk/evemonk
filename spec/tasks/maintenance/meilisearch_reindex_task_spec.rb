# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexTask do
  describe "#process" do
    specify { expect { subject.process }.not_to raise_error }
  end
end
