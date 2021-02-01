# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }

  describe "#date_founded" do
    let(:eve_alliance) do
      build(:eve_alliance,
        date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { eve_alliance.decorate }

    specify { expect(subject.date_founded).to eq("2015-05-03T19:45:17Z") }
  end
end
