require 'rails_helper'

describe Api::ProfilesController do
  describe 'routing' do
    it 'should route GET /api/profile to api/profiles#show' do
      expect(get: '/api/profile').to route_to(
        controller: 'api/profiles',
        action: 'show',
        format: 'json'
      )
    end
  end
end
