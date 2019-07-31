# frozen_string_literal: true

require "rails_helper"

describe Api::SignUpForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  describe "validations" do
    let(:params) do
      {
        email: "me@example.com",
        password: "password",
        password_confirmation: "password",
      }
    end

    subject { described_class.new(params) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password) }

    it { should validate_presence_of(:password_confirmation) }

    it { should validate_confirmation_of(:password) }
  end

  it { should delegate_method(:id).to(:session) }

  it { should delegate_method(:token).to(:session) }

  describe "#save" do
    context "when user valid" do
      let(:params) do
        {
          email: "me@example.com",
          password: "password",
          password_confirmation: "password",
        }
      end

      subject(:form) { described_class.new(params) }

      specify { expect(form.save).to eq(true) }

      specify { expect { form.save }.to change(User, :count).by(1) }

      specify { expect { form.save }.to change(Session, :count).by(1) }

      specify { expect { form.save }.to change { User.first&.authenticate("password")&.present? }.from(nil).to(true) }
    end

    context "when user not valid" do
      let(:params) do
        {
          email: nil,
          password: nil,
          password_confirmation: nil,
        }
      end

      subject(:form) { described_class.new(params) }

      specify { expect(form.save).to eq(false) }

      specify { expect { form.save }.not_to change(User, :count) }

      specify { expect { form.save }.not_to change(Session, :count) }
    end

    context "when user valid but email has already been taken" do
      let!(:existed_user) { create(:user, email: "ME@EXAMPLE.COM") }

      let(:params) do
        {
          email: "me@example.com",
          password: "password",
          password_confirmation: "password",
        }
      end

      subject(:form) { described_class.new(params) }

      specify { expect(form.save).to eq(false) }

      specify { expect { form.save }.to change { form.errors[:email] }.from([]).to(["has already been taken"]) }
    end
  end
end
