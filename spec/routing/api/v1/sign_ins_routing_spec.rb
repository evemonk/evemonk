require 'rails_helper'

describe Api::V1::SignInsController do
  describe 'routing' do
    it 'should route POST /api/v1/sign_in to api/v1/sign_ins#create' do
      expect(post: '/api/v1/sign_in').to route_to(
        controller: 'api/v1/sign_ins',
        action: 'create',
        format: 'json'
      )
    end
  end
end
