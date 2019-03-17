# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationsController do
  describe 'routing' do
    it 'should route GET /api/eve/corporations to api/eve/corporations#index' do
      expect(get: '/api/eve/corporations').to route_to(
        controller: 'api/eve/corporations',
        action: 'index',
        format: 'json'
      )
    end
  end
end
