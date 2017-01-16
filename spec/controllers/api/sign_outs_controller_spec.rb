require 'rails_helper'

describe Api::SignOutsController do
  it { should be_a(Api::BaseController) }

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
