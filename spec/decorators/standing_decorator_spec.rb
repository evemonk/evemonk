# frozen_string_literal: true

require "rails_helper"

describe StandingDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#standing" do
    let(:standing) { build(:standing, standing: 1.56789) }

    subject { standing.decorate }

    specify { expect(subject.standing).to eq("1.6") }
  end
end
