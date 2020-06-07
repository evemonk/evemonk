# frozen_string_literal: true

require "rails_helper"

describe SkillqueueDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  specify do
    expect(described_class::LEVELS).to eq(1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V")
  end

  describe "#finished_level" do
    let(:skillqueue) { build(:skillqueue, finished_level: 1) }

    subject { skillqueue.decorate }

    specify { expect(subject.finished_level).to eq("I") }
  end

  describe "#time_left" do
    before { travel_to Time.zone.now }

    after { travel_back }

    context "when start_date in past" do
      let(:skillqueue) do
        build(:skillqueue,
          start_date: Time.zone.now - 10.minutes,
          finish_date: Time.zone.now + 10.minutes)
      end

      subject { skillqueue.decorate }

      specify { expect(subject.time_left).to eq("10m") }
    end

    context "when start_Date in future" do
      let(:skillqueue) do
        build(:skillqueue,
          start_date: Time.zone.now + 10.minutes,
          finish_date: Time.zone.now + 30.minutes)
      end

      subject { skillqueue.decorate }

      specify { expect(subject.time_left).to eq("20m") }
    end
  end
end
