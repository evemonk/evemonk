require 'rails_helper'

describe Api::ApiKeysController do
  describe 'routing' do
    it 'should route GET /api/api_keys to api/api_keys#index' do
      expect(get: '/api/api_keys').to route_to(
        controller: 'api/api_keys',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route POST /api/api_keys to api/api_keys#create' do
      expect(post: '/api/api_keys').to route_to(
        controller: 'api/api_keys',
        action: 'create',
        format: 'json'
      )
    end

    it 'should route GET /api/api_keys/:id to api/api_keys#show' do
      expect(get: '/api/api_keys/42').to route_to(
        controller: 'api/api_keys',
        action: 'show',
        id: '42',
        format: 'json'
      )
    end

    it 'should route PUT /api/api_keys/:id to api/api_keys#update' do
      expect(put: '/api/api_keys/42').to route_to(
        controller: 'api/api_keys',
        action: 'update',
        id: '42',
        format: 'json'
      )
    end

    it 'should route PATCH /api/api_keys/:id to api/api_keys#update' do
      expect(patch: '/api/api_keys/42').to route_to(
        controller: 'api/api_keys',
        action: 'update',
        id: '42',
        format: 'json'
      )
    end

    it 'should route DELETE /api/api_keys/:id to api/api_keys#destroy' do
      expect(delete: '/api/api_keys/42').to route_to(
        controller: 'api/api_keys',
        action: 'destroy',
        id: '42',
        format: 'json'
      )
    end
  end
end
