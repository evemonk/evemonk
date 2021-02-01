# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemDecorator do
  xdescribe "#security_status" do
    context "when security status is 0.14" do
      let(:eve_system) { build(:eve_system, security_status: 0.14) }

      subject { eve_system.decorate }

      specify { expect(subject.security_status).to eq(0.1) }
    end

    context "when security status is 0.15" do
      let(:eve_system) { build(:eve_system, security_status: 0.15) }

      subject { eve_system.decorate }

      specify { expect(subject.security_status).to eq(0.2) }
    end
  end
end
