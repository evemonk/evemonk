# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AlliancesController do
  describe 'routing' do
    it 'should route GET /api/eve/alliances to api/eve/alliances#index' do
      expect(get: '/api/eve/alliances').to route_to(
        controller: 'api/eve/alliances',
        action: 'index',
        format: 'json'
      )
    end
  end
end
