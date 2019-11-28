# frozen_string_literal: true

require "rails_helper"

describe SignInForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  it { should delegate_method(:login).to(:controller) }

  describe "validations" do
    let!(:user) { create(:user, email: "me@example.com", password: "password") }

    let(:params) do
      {
        email: "me@example.com",
        password: "password",
        remember_me: "1",
      }
    end

    subject { described_class.new(params) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password) }

    it { should validate_inclusion_of(:remember_me).in_array(["0", "1"]) }
  end

  describe "#save" do
    let!(:user) { create(:user, email: "me@example.com", password: "password") }

    let(:params) do
      {
        email: "me@example.com",
        password: "password",
        remember_me: "1",
      }
    end

    let(:controller) { instance_double(ApplicationController) }

    subject { described_class.new(params.merge(controller: controller)) }

    context "when form valid" do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(controller).to receive(:login).with("me@example.com", "password", true).and_return(user) }

      specify { expect(subject.save).to eq(true) }
    end

    context "when form not valid" do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(controller).not_to receive(:login) }

      specify { expect(subject.save).to eq(false) }
    end
  end
end
