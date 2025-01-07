# frozen_string_literal: true

require "rails_helper"

RSpec.describe HumanTime, type: :model do
  it { expect(described_class::SECONDS_IN_DAY).to eq(86_400) }

  it { expect(described_class::SECONDS_IN_HOUR).to eq(3600) }

  it { expect(described_class::SECONDS_IN_MINUTE).to eq(60) }

  let(:seconds) { double }

  subject { described_class.new(seconds) }

  describe "#initialize" do
    its(:seconds) { is_expected.to eq(seconds) }

    its(:parsed) { is_expected.to eq(false) }
  end

  describe "#long_formatted" do
    context "when seconds blank" do
      let(:seconds) { nil }

      specify { expect(subject.long_formatted).to eq(nil) }
    end

    context "when seconds present" do
      context "when singular form" do
        let(:seconds) { 1.day.to_i + 1.hour.to_i + 1.minute.to_i + 1.second.to_i }

        specify { expect(subject.long_formatted).to eq("1 day 1 hour 1 minute 1 second") }
      end

      context "when plural form" do
        let(:seconds) { 5.days.to_i + 4.hours.to_i + 3.minutes.to_i + 2.seconds.to_i }

        specify { expect(subject.long_formatted).to eq("5 days 4 hours 3 minutes 2 seconds") }
      end
    end
  end

  describe "#short_formatted" do
    context "when seconds blank" do
      let(:seconds) { nil }

      specify { expect(subject.short_formatted).to eq(nil) }
    end

    context "when seconds present" do
      let(:seconds) { 5.days.to_i + 4.hours.to_i + 3.minutes.to_i + 2.seconds.to_i }

      specify { expect(subject.short_formatted).to eq("5d 4h 3m 2s") }
    end
  end

  describe "#very_short_formatted" do
    let(:seconds) { 5.days.to_i + 4.hours.to_i + 3.minutes.to_i + 2.seconds.to_i }

    specify { expect(subject.very_short_formatted).to eq("5d 4h") }
  end
end
