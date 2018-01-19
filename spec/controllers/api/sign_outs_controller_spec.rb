# frozen_string_literal: true

require 'rails_helper'

describe Api::SignOutsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate!) }

  describe '#destroy' do
    context 'authorized' do
      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{session.token}" }

      before { delete :destroy, format: :json }

      it { should respond_with(:no_content) }
    end

    context 'not authorized' do
      before { delete :destroy, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end
end
