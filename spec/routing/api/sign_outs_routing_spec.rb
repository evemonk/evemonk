require 'rails_helper'

describe Api::SignOutsController do
  describe 'routing' do
    it 'should route DELETE /api/sign_outs to api/sign_outs#destroy' do
      expect(delete: '/api/sign_outs').to route_to(
        controller: 'api/sign_outs',
        action: 'destroy',
        format: 'json'
      )
    end
  end
end
