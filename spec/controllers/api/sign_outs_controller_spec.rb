# frozen_string_literal: true

require 'rails_helper'

describe Api::SignOutsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate) }

  describe '#destroy' do
    context 'when user authorized' do
      before { sign_in }

      let(:request1) { double.as_null_object }

      before { expect(subject).to receive(:request).and_return(request1).at_least(:once) }

      before do
        #
        # Api::SignOutForm.new(request).destroy!
        #
        expect(Api::SignOutForm).to receive(:new).with(request1) do
          double.tap do |a|
            expect(a).to receive(:destroy)
          end
        end
      end

      before { delete :destroy, params: { format: :json } }

      it { should respond_with(:no_content) }
    end

    context 'when user not authorized' do
      before { delete :destroy, params: { format: :json } }

      it { should respond_with(:unauthorized) }
    end

    context 'when not supported accept type' do
      before { delete :destroy, params: { format: :html } }

      pending { should respond_with(:not_acceptable) }
    end
  end
end
