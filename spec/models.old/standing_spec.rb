# frozen_string_literal: true

require "rails_helper"

describe Standing do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:character) }

  it { should belong_to(:standingable).optional(true) }

  describe "#rounded_standing" do
    subject { build(:standing, standing: 1.56789) }

    specify { expect(subject.rounded_standing).to eq("1.6") }
  end
end
