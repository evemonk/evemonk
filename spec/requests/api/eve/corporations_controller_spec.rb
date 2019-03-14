# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationsController do
  describe '#index' do
    it 'returns list of Eve Corporations' do
      create(:eve_alliance,
             alliance_id: 123)
             # creator_corporation_id: 123_123,
             # creator_id: 123_123_123,
             # date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             # executor_corporation_id: 123_123_123_123,
             # faction_id: 777,
             # name: 'Alliance name',
             # ticker: 'ABCDE')

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456)
             # member_count: 1234)

      get '/api/eve/corporations'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 1,
                                              'total_pages' => 1,
                                              'current_page' => 1,
                                              'corporations' => [{
                                                'id' => 456,
                                                'icon' => 'http://imageserver.eveonline.com/Corporation/456_256.png'
                                              }])
    end
  end
end
