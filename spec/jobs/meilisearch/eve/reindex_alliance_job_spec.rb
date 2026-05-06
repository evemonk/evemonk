# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meilisearch::Eve::ReindexAllianceJob, type: :job do
  it { expect(described_class.queue_name).to eq("meilisearch") }
end
