require 'rails_helper'

describe Api::SignUpsController do
  describe 'routing' do
    it 'should route POST /api/sign_up to api/sign_ups#create' do
      expect(post: '/api/sign_up').to route_to(
        controller: 'api/sign_ups',
        action: 'create',
        format: 'json'
      )
    end
  end
end
