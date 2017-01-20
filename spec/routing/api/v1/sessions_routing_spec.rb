require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'routing' do
    it 'should route GET /api/v1/sessions to api/v1/sessions#index' do
      expect(get: '/api/v1/sessions').to route_to(
        controller: 'api/v1/sessions',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route DELETE /api/v1/sessions/:id to api/v1/sessions#destroy' do
      expect(delete: '/api/v1/sessions/1234').to route_to(
        controller: 'api/v1/sessions',
        action: 'destroy',
        format: 'json',
        id: '1234'
      )
    end
  end
end
