# frozen_string_literal: true

require "rails_helper"

describe PushNotifications::NewSignIn do
  let(:device) { double }

  let(:device_token) { double }

  let(:notifications_count) { double }

  subject { described_class.new(device, device_token, notifications_count) }

  specify { expect(subject).to be_a(PushNotifications::Base) }

  describe "#alert" do
    specify { expect(subject.send(:alert)).to eq("New sign-in from Location (IP)") }
  end
end
