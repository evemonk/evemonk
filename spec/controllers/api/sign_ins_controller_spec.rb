require 'rails_helper'

describe Api::SignInsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#create.json' do
    context 'successful authorization' do
      let!(:user) { create(:user, password: 'password') }

      before do
        post :create, params: { sign_ins: {
            email: user.email,
            password: 'password'
        }, format: :json }
      end

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    context 'failed authorization' do
      before do
        post :create, params: { sign_ins: {
            email: 'me@example.com',
            password: 'password'
        }, format: :json }
      end

      it { should render_template(:errors) }

      it { should respond_with(:unprocessable_entity) }
    end
  end
end
