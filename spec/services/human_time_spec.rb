# frozen_string_literal: true

require "rails_helper"

describe HumanTime do
  it { expect(described_class::SECONDS_IN_DAY).to eq(86400) }

  it { expect(described_class::SECONDS_IN_HOUR).to eq(3600) }

  it { expect(described_class::SECONDS_IN_MINUTE).to eq(60) }
end
