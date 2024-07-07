# frozen_string_literal: true

require "rails_helper"

RSpec.describe WelcomeMailer do
  describe "#email" do
    let(:user) do
      create(:user,
        email: "me@example.com")
    end

    subject { described_class.with(user: user).email }

    specify { expect(subject.subject).to eq("Welcome to evemonk.com") }

    specify { expect(subject.to).to eq(["me@example.com"]) }

    specify { expect(subject.from).to eq(["robot@evemonk.com"]) }

    specify { expect(subject.body).to include("Welcome!") }
  end
end
