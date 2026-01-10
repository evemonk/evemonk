# frozen_string_literal: true

require "rails_helper"

RSpec.describe PasswordsMailer do
  describe "#reset" do
    let(:user) do
      create(:user,
        email_address: "me@example.com")
    end

    subject { described_class.reset(user) }

    specify { expect(subject.subject).to eq("Reset your password") }

    specify { expect(subject.to).to eq(["me@example.com"]) }

    specify { expect(subject.from).to eq(["robot@evemonk.com"]) }

    specify { expect(subject.body.parts.first.body).to include("You can reset your password on") }

    specify { expect(subject.body.parts.last.body).to include("You can reset your password on") }
  end
end
