require 'rails_helper'

describe Api::V1::SignUpsController do
  describe 'routing' do
    it 'should route POST /api/v1/sign_up to api/v1/sign_ups#create' do
      expect(post: '/api/v1/sign_up').to route_to(
        controller: 'api/v1/sign_ups',
        action: 'create',
        format: 'json'
      )
    end
  end
end
