# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationDecorator do
  xdescribe "#tax_rate" do
    let(:eve_corporation) do
      build(:eve_corporation,
        tax_rate: 0.99)
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.tax_rate).to eq("0.99") }
  end
end
