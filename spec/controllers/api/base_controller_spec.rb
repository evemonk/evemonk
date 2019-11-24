# frozen_string_literal: true

require "rails_helper"

describe Api::BaseController do
  it { should be_a(ActionController::Base) }

  it { should use_before_action(:verify_requested_format!) }

  it { should use_before_action(:authenticate) }

  describe "#current_user" do
    let!(:user) { instance_double(User) }

    before { subject.instance_variable_set(:@current_user, user) }

    specify { expect(subject.current_user).to eq(user) }
  end

  it { should rescue_from(ActiveRecord::RecordNotFound) }

  it { should rescue_from(ActionController::UnknownFormat) }

  # private methods

  describe "#authenticate_by_token" do
    context "when user exists" do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      before { expect(subject).to receive(:authenticate_with_http_token).and_yield(session.token) }

      specify { expect(subject.send(:authenticate_by_token)).to eq(user) }
    end

    context "when user not exists" do
      specify { expect(subject.send(:authenticate_by_token)).to eq(nil) }
    end
  end

  describe "#authenticate" do
    context "when user exists" do
      let(:user) { instance_double(User) }

      before { expect(subject).to receive(:authenticate_by_token).and_return(user) }

      specify { expect(subject.send(:authenticate)).to eq(user) }
    end

    context "when user not exists" do
      before { expect(subject).to receive(:authenticate_by_token).and_return(nil) }

      before { expect(subject).to receive(:render_unauthorized) }

      specify { expect { subject.send(:authenticate) }.not_to raise_error }
    end
  end

  describe "#render_unauthorized" do
    before { expect(subject).to receive(:render).with(json: {error: "Access denied"}, status: :unauthorized) }

    specify { expect { subject.send(:render_unauthorized) }.not_to raise_error }
  end
end
