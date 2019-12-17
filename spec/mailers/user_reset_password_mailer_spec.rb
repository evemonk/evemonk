# frozen_string_literal: true

require "rails_helper"

describe UserResetPasswordMailer do
  describe "#email" do
    let(:user) do
      create(:user,
        email: "me@example.com",
        reset_password_token: "reset-token-123")
    end

    subject { described_class.with(user: user).email }

    specify { expect(subject.subject).to eq("Reset password at evemonk.com") }

    specify { expect(subject.to).to eq(["me@example.com"]) }

    specify { expect(subject.from).to eq(["robot@evemonk.com"]) }

    specify { expect(subject.body).to include("reset-token-123") }
  end
end
