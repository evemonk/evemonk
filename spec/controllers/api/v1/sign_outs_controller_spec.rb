require 'rails_helper'

describe Api::V1::SignOutsController do
  it { should be_a(Api::V1::BaseController) }

  it { should use_before_action(:authenticate) }

  describe '#destroy.json' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      before { sign_in(user) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { delete :destroy, format: :json }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { delete :destroy, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end
end
