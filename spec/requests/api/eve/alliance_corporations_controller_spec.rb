# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AllianceCorporationsController do
  describe '#index' do
    it 'returns list of Eve Alliance Corporations' do
      create(:eve_alliance,
             alliance_id: 123,
             creator_corporation_id: 2222,
             creator_id: 3333,
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             executor_corporation_id: 4444,
             faction_id: 5555,
             name: 'Alliance name',
             ticker: 'ALLIANCE_TICKER')

      get '/api/eve/alliances/123/corporations'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 0,
                                              'total_pages' => 0,
                                              'current_page' => 1,
                                              'corporations' => [])
    end

    it 'returns 404' do
      get '/api/eve/alliances/123/corporations'

      expect(response).to have_http_status(:not_found)
    end
  end
end
