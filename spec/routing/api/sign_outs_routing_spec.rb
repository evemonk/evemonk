require 'rails_helper'

describe Api::SignOutsController do
  describe 'routing' do
    it 'should route DELETE /api/sign_out to api/sign_outs#destroy' do
      expect(delete: '/api/sign_out').to route_to(
        controller: 'api/sign_outs',
        action: 'destroy',
        format: 'json'
      )
    end
  end
end
