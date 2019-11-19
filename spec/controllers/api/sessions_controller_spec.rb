# frozen_string_literal: true

require "rails_helper"

describe Api::SessionsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate) }

  describe "#index" do
    context "when user signed in" do
      before { sign_in }

      before do
        #
        # subject.policy_scope(Session).order(created_at: :asc)
        #                              .page(params[:page])
        #
        expect(subject).to receive(:policy_scope).with(Session) do
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
      let(:session) { instance_double(Session) }

      before { sign_in }

      before { expect(Session).to receive(:find).with("1").and_return(session) }

      before { expect(subject).to receive(:authorize).with(session) }

      before { expect(session).to receive(:destroy!) }

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
