# frozen_string_literal: true

require "rails_helper"

describe Api::SignOutsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate) }

  describe "#destroy" do
    context "when user authorized" do
      before { api_sign_in }

      let(:form) { instance_double(Api::SignOutForm) }

      let(:request1) { double.as_null_object }

      before { expect(subject).to receive(:request).and_return(request1).at_least(:once) }

      before { expect(Api::SignOutForm).to receive(:new).with(request1).and_return(form) }

      before { expect(form).to receive(:destroy!) }

      before { delete :destroy, params: {format: :json} }

      it { should respond_with(:no_content) }
    end

    context "when user not authorized" do
      before { delete :destroy, params: {format: :json} }

      it { should respond_with(:unauthorized) }
    end

    context "when not supported accept type" do
      before { delete :destroy, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
