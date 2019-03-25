# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AlliancesSearchController do
  describe 'routing' do
    it 'should route GET /api/eve/alliances/search to api/eve/alliances_search#index' do
      expect(get: '/api/eve/alliances/search').to route_to(
        controller: 'api/eve/alliances_search',
        action: 'index',
        format: 'json'
      )
    end
  end
end
