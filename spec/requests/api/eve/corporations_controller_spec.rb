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

      expect(JSON.parse(response.body).keys.sort).to eq(['corporations', 'current_page', 'total_count', 'total_pages'])

      expect(JSON.parse(response.body)['total_count']).to eq(1)

      expect(JSON.parse(response.body)['total_pages']).to eq(1)

      expect(JSON.parse(response.body)['current_page']).to eq(1)

      expect(JSON.parse(response.body)['corporations'].size).to eq(1)

      expect(JSON.parse(response.body)['corporations'].first.keys.sort).to eq(['date_founded', 'description', 'icon', 'id', 'member_count', 'name', 'ticker'])

      expect(JSON.parse(response.body)['corporations'].first['id']).to eq(456)

      expect(JSON.parse(response.body)['corporations'].first['icon']).to eq('https://imageserver.eveonline.com/Corporation/456_256.png')

      expect(JSON.parse(response.body)['corporations'].first['date_founded']).to eq('2015-05-03T19:45:17Z')

      expect(JSON.parse(response.body)['corporations'].first['name']).to eq('Character corporation name')

      expect(JSON.parse(response.body)['corporations'].first['description']).to eq('Character corporation description')

      expect(JSON.parse(response.body)['corporations'].first['member_count']).to eq(2000)

      expect(JSON.parse(response.body)['corporations'].first['ticker']).to eq('TICKER')
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

      expect(JSON.parse(response.body).keys.sort).to eq(['corporation'])

      expect(JSON.parse(response.body)['corporation'].keys.sort).to eq(['alliance', 'date_founded', 'description', 'icon', 'id', 'member_count', 'name', 'ticker'])

      expect(JSON.parse(response.body)['corporation']['id']).to eq(456)

      expect(JSON.parse(response.body)['corporation']['icon']).to eq('https://imageserver.eveonline.com/Corporation/456_256.png')

      expect(JSON.parse(response.body)['corporation']['date_founded']).to eq('2015-05-03T19:45:17Z')

      expect(JSON.parse(response.body)['corporation']['name']).to eq('Character corporation name')

      expect(JSON.parse(response.body)['corporation']['description']).to eq('Character corporation description')

      expect(JSON.parse(response.body)['corporation']['member_count']).to eq(2000)

      expect(JSON.parse(response.body)['corporation']['ticker']).to eq('TICKER')
    end

    it 'returns 404' do
      get '/api/eve/corporations/123'

      expect(response).to have_http_status(:not_found)
    end
  end
end
