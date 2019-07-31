# frozen_string_literal: true

require "rails_helper"

describe Eve::FactionDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#size_factor" do
    let(:eve_faction) do
      build(:eve_faction,
            size_factor: 2.0)
    end

    subject { eve_faction.decorate }

    specify { expect(subject.size_factor).to eq("2.0") }
  end
end
