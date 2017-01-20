require 'rails_helper'

describe Api::V1::ProfilesController do
  describe 'routing' do
    it 'should route GET /api/v1/profile to api/v1/profiles#show' do
      expect(get: '/api/v1/profile').to route_to(
        controller: 'api/v1/profiles',
        action: 'show',
        format: 'json'
      )
    end
  end
end
