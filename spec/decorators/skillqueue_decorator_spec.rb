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
end
