require 'rails_helper'

describe Api::DocsController do
  describe 'routing' do
    it 'should route GET /api/docs to api/docs#index' do
      expect(get: '/api/docs').to route_to(
        controller: 'api/docs',
        action: 'index',
        format: 'json'
      )
    end
  end
end
