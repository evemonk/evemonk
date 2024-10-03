# frozen_string_literal: true

require "rails_helper"

RSpec.describe Skillqueue do
  it { is_expected.to be_an(ApplicationRecord) }

  specify do
    expect(described_class::LEVELS).to eq(1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V")
  end

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:skill).class_name("Eve::Type").optional(true) }

  describe "#finished_level_formatted" do
    subject { build(:skillqueue, finished_level: 1) }

    specify { expect(subject.finished_level_formatted).to eq("I") }
  end

  describe "#time_left" do
    before { freeze_time }

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
