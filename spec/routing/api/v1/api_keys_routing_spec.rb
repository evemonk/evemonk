require 'rails_helper'

describe Api::V1::ApiKeysController do
  describe 'routing' do
    it 'should route GET /api/v1/api_keys to api/v1/api_keys#index' do
      expect(get: '/api/v1/api_keys').to route_to(
        controller: 'api/v1/api_keys',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route POST /api/v1/api_keys to api/v1/api_keys#create' do
      expect(post: '/api/v1/api_keys').to route_to(
        controller: 'api/v1/api_keys',
        action: 'create',
        format: 'json'
      )
    end

    it 'should route GET /api/v1/api_keys/:id to api/v1/api_keys#show' do
      expect(get: '/api/v1/api_keys/42').to route_to(
        controller: 'api/v1/api_keys',
        action: 'show',
        id: '42',
        format: 'json'
      )
    end

    it 'should route PUT /api/v1/api_keys/:id to api/v1/api_keys#update' do
      expect(put: '/api/v1/api_keys/42').to route_to(
        controller: 'api/v1/api_keys',
        action: 'update',
        id: '42',
        format: 'json'
      )
    end

    it 'should route PATCH /api/v1/api_keys/:id to api/v1/api_keys#update' do
      expect(patch: '/api/v1/api_keys/42').to route_to(
        controller: 'api/v1/api_keys',
        action: 'update',
        id: '42',
        format: 'json'
      )
    end

    it 'should route DELETE /api/v1/api_keys/:id to api/v1/api_keys#destroy' do
      expect(delete: '/api/v1/api_keys/42').to route_to(
        controller: 'api/v1/api_keys',
        action: 'destroy',
        id: '42',
        format: 'json'
      )
    end
  end
end
