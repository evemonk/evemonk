# frozen_string_literal: true

require "rails_helper"

describe Skillqueue do
  it { should be_an(ApplicationRecord) }

  specify do
    expect(described_class::LEVELS).to eq(1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V")
  end

  it { should belong_to(:character) }

  it { should belong_to(:skill).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("skill_id").optional(true) }

  describe "#finished_level_formatted" do
    subject { build(:skillqueue, finished_level: 1) }

    specify { expect(subject.finished_level_formatted).to eq("I") }
  end

  describe "#time_left" do
    before { travel_to Time.zone.now }

    after { travel_back }

    context "when start_date in past" do
      subject do
        build(:skillqueue,
          start_date: 10.minutes.ago,
          finish_date: 10.minutes.from_now)
      end

      specify { expect(subject.time_left).to eq("10m") }
    end

    context "when start_date in future" do
      subject do
        build(:skillqueue,
          start_date: 10.minutes.from_now,
          finish_date: 30.minutes.from_now)
      end

      specify { expect(subject.time_left).to eq("20m") }
    end
  end
end
