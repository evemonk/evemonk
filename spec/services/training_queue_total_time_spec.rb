# frozen_string_literal: true

require "rails_helper"

describe TrainingQueueTotalTime do
  describe "#initialize" do
    let(:skillqueues) { double }

    let(:character) { instance_double(Character, skillqueues: skillqueues) }

    subject { described_class.new(character.skillqueues) }

    its(:skillqueues) { should eq(skillqueues) }
  end

  describe "#total_time" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let!(:character) { create(:character) }

    context "when start_date in future" do
      let!(:skillqueue_1) do
        create(:skillqueue,
          character: character,
          start_date: Time.zone.now,
          finish_date: 1.hour.from_now)
      end

      let!(:skillqueue_2) do
        create(:skillqueue,
          character: character,
          start_date: 1.hour.from_now,
          finish_date: 2.hours.from_now)
      end

      subject { described_class.new(character.skillqueues) }

      specify { expect(subject.total_time).to eq("2h") }
    end

    context "when start_date in past" do
      let!(:skillqueue_1) do
        create(:skillqueue,
          character: character,
          start_date: 2.hours.ago,
          finish_date: 1.hour.from_now)
      end

      let!(:skillqueue_2) do
        create(:skillqueue,
          character: character,
          start_date: 1.hour.from_now,
          finish_date: 2.hours.from_now)
      end

      subject { described_class.new(character.skillqueues) }

      specify { expect(subject.total_time).to eq("2h") }
    end
  end
end
