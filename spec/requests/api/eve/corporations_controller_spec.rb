# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationsController do
  describe '#index' do
    it 'returns list of Eve Corporations' do
      create(:eve_alliance,
             alliance_id: 123)

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456,
             name: 'Character corporation name',
             description: '<b>Character corporation description</b>',
             ticker: 'TICKER',
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             member_count: 2000)

      get '/api/eve/corporations'

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
                                                'description' => 'Character corporation description',
                                                'ticker' => 'TICKER'
                                              }])
    end
  end

  describe '#show' do
    it 'returns Eve Corporation' do
      create(:eve_alliance,
             alliance_id: 123)

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456,
             name: 'Character corporation name',
             description: '<b>Character corporation description</b>',
             ticker: 'TICKER',
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             member_count: 2000)

      get '/api/eve/corporations/456'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('corporation' => {
                                                'date_founded' => '2015-05-03T19:45:17Z',
                                                'icon' => 'https://imageserver.eveonline.com/Corporation/456_256.png',
                                                'id' => 456,
                                                'member_count' => 2000,
                                                'name' => 'Character corporation name',
                                                'description' => 'Character corporation description',
                                                'ticker' => 'TICKER'
                                              })
    end

    it 'returns 404' do
      get '/api/eve/corporations/123'

      expect(response).to have_http_status(:not_found)
    end
  end
end
