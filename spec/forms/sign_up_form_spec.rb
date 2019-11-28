# frozen_string_literal: true

require "rails_helper"

describe SignUpForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  it { should delegate_method(:login).to(:controller) }

  describe "validations" do
    let(:params) do
      {
        email: "me@example.com",
        password: "password",
        password_confirmation: "password",
        remember_me: "1",
      }
    end

    subject { described_class.new(params) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password) }

    it { should validate_presence_of(:password_confirmation) }

    it { should validate_confirmation_of(:password) }

    it { should validate_inclusion_of(:remember_me).in_array(["0", "1"]) }
  end

  describe "#save" do
    let(:params) do
      {
        email: "me@example.com",
        password: "password",
        password_confirmation: "password",
        remember_me: "1",
      }
    end

    let(:controller) { instance_double(ApplicationController) }

    subject { described_class.new(params.merge(controller: controller)) }

    context "when form valid" do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:create_user!) }

      before { expect(controller).to receive(:login).with("me@example.com", "password", true) }

      specify { expect(subject.save).to eq(true) }
    end

    context "when form not valid" do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(subject).not_to receive(:create_user!) }

      before { expect(controller).not_to receive(:login) }

      specify { expect(subject.save).to eq(false) }
    end

    context "when email already taken" do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:create_user!).and_raise(ActiveRecord::RecordNotUnique) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to(change { subject.errors[:email] }.from([]).to(["has already been taken"])) }
    end
  end

  # private methods

  describe "#create_user!" do
    let(:params) do
      {
        email: "me@example.com",
        password: "password",
        password_confirmation: "password",
        remember_me: "1",
      }
    end

    let(:controller) { instance_double(ApplicationController) }

    subject { described_class.new(params.merge(controller: controller)) }

    before { expect(User).to receive(:create!).with(email: "me@example.com", password: "password") }

    specify { expect { subject.send(:create_user!) }.not_to raise_error }
  end
end
