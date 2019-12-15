# frozen_string_literal: true

require "rails_helper"

describe ChangePasswordsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#show" do
    context "when user signed in" do
      let(:current_user) { instance_double(User) }

      before { sign_in(current_user) }

      before { expect(current_user).to receive(:set_last_activity_at).with(any_args) }

      before { get :show }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when user not signed in" do
      context "when format js" do
        before { get :show, params: {format: "js"} }

        it { should redirect_to(sign_in_path) }
      end

      context "when format html" do
        before { get :show, params: {format: "html"} }

        it { should redirect_to(sign_in_path) }
      end
    end
  end
end
