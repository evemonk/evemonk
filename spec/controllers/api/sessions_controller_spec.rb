# frozen_string_literal: true

require "rails_helper"

describe Api::SessionsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate) }

  describe "#index" do
    context "when user signed in" do
      let(:current_user) { instance_double(User) }

      before { sign_in(current_user) }

      before do
        #
        # current_user.sessions
        #   .order(created_at: :asc)
        #   .page(params[:page])
        #
        expect(current_user).to receive(:sessions) do
          double.tap do |a|
            expect(a).to receive(:order).with(created_at: :asc) do
              double.tap do |b|
                expect(b).to receive(:page).with("1")
              end
            end
          end
        end
      end

      before { get :index, params: {format: :json, page: "1"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {format: :json} }

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe "#destroy" do
    context "when user signed in" do
      let(:current_user) { instance_double(User) }

      before { sign_in(current_user) }

      before do
        #
        # current_user.sessions.find(params[:id]).destroy!
        #
        expect(current_user).to receive(:sessions) do
          double.tap do |a|
            expect(a).to receive(:find).with("1") do
              double.tap do |b|
                expect(b).to receive(:destroy!)
              end
            end
          end
        end
      end

      before { delete :destroy, params: {id: "1", format: :json} }

      it { should respond_with(:no_content) }
    end

    context "when user not signed in" do
      before { delete :destroy, params: {id: "1", format: :json} }

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before { delete :destroy, params: {id: "1", format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
