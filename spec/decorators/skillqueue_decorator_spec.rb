# frozen_string_literal: true

require "rails_helper"

describe SkillqueueDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#finished_level" do
    context "when finish level is 1" do
      let(:skillqueue) { build(:skillqueue, finished_level: 1) }

      subject { skillqueue.decorate }

      specify { expect(subject.finished_level).to eq("I") }
    end

    context "when finish level is 2" do
      let(:skillqueue) { build(:skillqueue, finished_level: 2) }

      subject { skillqueue.decorate }

      specify { expect(subject.finished_level).to eq("II") }
    end

    context "when finish level is 3" do
      let(:skillqueue) { build(:skillqueue, finished_level: 3) }

      subject { skillqueue.decorate }

      specify { expect(subject.finished_level).to eq("III") }
    end

    context "when finish level is 4" do
      let(:skillqueue) { build(:skillqueue, finished_level: 4) }

      subject { skillqueue.decorate }

      specify { expect(subject.finished_level).to eq("IV") }
    end

    context "when finish level is 5" do
      let(:skillqueue) { build(:skillqueue, finished_level: 5) }

      subject { skillqueue.decorate }

      specify { expect(subject.finished_level).to eq("V") }
    end

    context "when finish level is unknown" do
      let(:skillqueue) { build(:skillqueue, finished_level: 6) }

      subject { skillqueue.decorate }

      specify { expect { subject.finished_level }.to raise_error("Unknown finished level") }
    end
  end
end
