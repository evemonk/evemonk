# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AllianceCorporationsController do
  describe '#index' do
    it 'returns list of Eve Alliance Corporations' do
      create(:eve_alliance,
             alliance_id: 123)

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456,
             name: 'Character corporation name',
             ticker: 'TICKER',
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             member_count: 2000)

      get '/api/eve/alliances/123/corporations'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 1,
                                              'total_pages' => 1,
                                              'current_page' => 1,
                                              'corporations' => [{
                                                'date_founded' => '2015-05-03T19:45:17Z',
                                                'icon' => 'https://imageserver.eveonline.com/Corporation/456_256.png',
                                                'id' => 456,
                                                'member_count' => 2000,
                                                'name' => 'Character corporation name',
                                                'ticker' => 'TICKER'
                                              }])
    end

    it 'returns 404' do
      get '/api/eve/alliances/123/corporations'

      expect(response).to have_http_status(:not_found)
    end
  end
end
