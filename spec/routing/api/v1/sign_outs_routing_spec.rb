require 'rails_helper'

describe Api::V1::SignOutsController do
  describe 'routing' do
    it 'should route DELETE /api/v1/sign_out to api/v1/sign_outs#destroy' do
      expect(delete: '/api/v1/sign_out').to route_to(
        controller: 'api/v1/sign_outs',
        action: 'destroy',
        format: 'json'
      )
    end
  end
end
