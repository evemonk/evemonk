# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationDecorator do
  xdescribe "#date_founded" do
    context "when date_founded is empty" do
      let(:eve_corporation) do
        build(:eve_corporation,
          date_founded: nil)
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.date_founded).to eq(nil) }
    end

    context "when date_founded is present" do
      let(:eve_corporation) do
        build(:eve_corporation,
          date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { eve_corporation.decorate }

      specify { expect(subject.date_founded).to eq("2015-05-03T19:45:17Z") }
    end
  end

  xdescribe "#description" do
    let(:eve_corporation) do
      build(:eve_corporation,
        description: "<b>Test</b>")
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  xdescribe "#tax_rate" do
    let(:eve_corporation) do
      build(:eve_corporation,
        tax_rate: 0.99)
    end

    subject { eve_corporation.decorate }

    specify { expect(subject.tax_rate).to eq("0.99") }
  end
end
