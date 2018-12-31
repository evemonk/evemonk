# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AlliancesController do
  describe '#index' do
    it 'returns list of Eve Alliances' do
      create(:eve_faction,
             faction_id: 777,
             name: 'Faction name',
             description: 'Faction description')

      create(:eve_alliance,
             alliance_id: 123,
             creator_corporation_id: 123_123,
             creator_id: 123_123_123,
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             executor_corporation_id: 123_123_123_123,
             faction_id: 777,
             name: 'Alliance name',
             ticker: 'ABCDE')

      get '/api/eve/alliances'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 1,
                                              'total_pages' => 1,
                                              'current_page' => 1,
                                              'alliances' => [{
                                                'id' => 123,
                                                'icon' => 'https://imageserver.eveonline.com/Alliance/123_128.png',
                                                'name' => 'Alliance name',
                                                'ticker' => 'ABCDE',
                                                'date_founded' => '2015-05-03T19:45:17.000Z',
                                                'corporations_count' => 0,
                                                'characters_count' => 0,
                                                'faction' => {
                                                  'id' => 777,
                                                  'name' => 'Faction name',
                                                  'description' => 'Faction description'
                                                }
                                              }])
    end
  end

  describe '#show' do
  end
end
