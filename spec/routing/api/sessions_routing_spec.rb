require 'rails_helper'

describe Api::SessionsController do
  describe 'routing' do
    it 'should route POST /api/sessions to api/sessions#create' do
      expect(post: '/api/sessions').to route_to(
        controller: 'api/sessions',
        action: 'create',
        format: 'json')
    end
  end
end
