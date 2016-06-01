require 'rails_helper'

describe Api::SignupsController do
  describe 'routing' do
    it 'should route POST /api/signups to api/signups#create' do
      expect(post: '/api/signups').to route_to(
        controller: 'api/signups',
        action: 'create',
        format: 'json')
    end
  end
end
