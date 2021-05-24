# frozen_string_literal: true

require "rails_helper"

describe CountriesMapper do
  describe ".countries" do
    specify { expect(described_class.countries[230]).to eq(name: "Ukraine", code: "+380") }
  end
end
