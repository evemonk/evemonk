# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::RacesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }
end
