# frozen_string_literal: true

require "rails_helper"

describe UserResetPasswordMailer do
  describe "#email" do
    let(:user) do
      create(:user,
        email: "me@example.com",
        reset_password_token: "reset-token-123")
    end

    subject(:mailer) { described_class.with(user: user).email }

    specify { expect(mailer.subject).to eq("Reset password at evemonk.com") }

    specify { expect(mailer.to).to eq(["me@example.com"]) }

    specify { expect(mailer.from).to eq(["from@example.com"]) }

    specify { expect(mailer.body).to include("reset-token-123") }
  end
end
