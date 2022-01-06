# frozen_string_literal: true

require "rails_helper"

describe CountriesMapper do
  describe ".countries" do
    specify { expect(described_class.countries.size).to eq(249) }

    specify { expect(described_class.countries[231]).to eq(name: "Ukraine", code: "+380") }
  end
end
