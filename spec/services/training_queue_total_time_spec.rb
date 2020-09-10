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
      let!(:skillqueue1) do
        create(:skillqueue,
          character: character,
          start_date: Time.zone.now,
          finish_date: Time.zone.now + 1.hour)
      end

      let!(:skillqueue2) do
        create(:skillqueue,
          character: character,
          start_date: Time.zone.now + 1.hour,
          finish_date: Time.zone.now + 2.hours)
      end

      subject { described_class.new(character.skillqueues) }

      specify { expect(subject.total_time).to eq("2h") }
    end

    context "when start_date in past" do
      let!(:skillqueue1) do
        create(:skillqueue,
          character: character,
          start_date: Time.zone.now - 2.hours,
          finish_date: Time.zone.now + 1.hour)
      end

      let!(:skillqueue2) do
        create(:skillqueue,
          character: character,
          start_date: Time.zone.now + 1.hour,
          finish_date: Time.zone.now + 2.hours)
      end

      subject { described_class.new(character.skillqueues) }

      specify { expect(subject.total_time).to eq("2h") }
    end
  end
end
