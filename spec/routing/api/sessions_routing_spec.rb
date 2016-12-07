require 'rails_helper'

describe Api::SessionsController do
  describe 'routing' do
    it 'should route POST /api/sessions to api/sessions#create' do
      expect(post: '/api/sessions').to route_to(
        controller: 'api/sessions',
        action: 'create',
        format: 'json'
      )
    end

    it 'should route DELETE /api/sessions to api/sessions#destroy' do
      expect(delete: '/api/sessions').to route_to(
        controller: 'api/sessions',
        action: 'destroy',
        format: 'json'
      )
    end
  end
end
