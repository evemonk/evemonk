# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController do
  describe '#index' do
    it 'returns list of user characters' do
      user = create(:user)

      session = create(:session, user: user)

      create(:character, user: user, character_id: '123', name: 'Character name')

      get '/api/characters', headers: { 'Authorization': "Bearer #{ session.token }" }

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).keys.sort).to eq(['characters', 'current_page', 'total_count', 'total_pages'])

      expect(JSON.parse(response.body)['total_count']).to eq(1)

      expect(JSON.parse(response.body)['total_pages']).to eq(1)

      expect(JSON.parse(response.body)['current_page']).to eq(1)

      expect(JSON.parse(response.body)['characters'].size).to eq(1)

      expect(JSON.parse(response.body)['characters'].first.keys.sort).to eq(['icon', 'id', 'name'])

      expect(JSON.parse(response.body)['characters'].first['id']).to eq(123)

      expect(JSON.parse(response.body)['characters'].first['icon']).to eq('https://imageserver.eveonline.com/Character/123_512.jpg')

      expect(JSON.parse(response.body)['characters'].first['name']).to eq('Character name')
    end
  end

  describe '#show' do
    it 'returns user character info' do
      user = create(:user)

      session = create(:session, user: user)

      alliance = create(:eve_alliance,
                        alliance_id: 1234,
                        name: 'Alliance name')

      corporation = create(:eve_corporation,
                           alliance_id: alliance.alliance_id,
                           corporation_id: 12_345,
                           name: 'Corporation name')

      character = create(:character,
                         user: user,
                         alliance_id: alliance.alliance_id,
                         corporation_id: corporation.corporation_id,
                         character_id: '123',
                         name: 'Character name',
                         description: 'Character description',
                         birthday: '2010-01-15T15:26:00Z',
                         gender: 'male',
                         charisma: 20,
                         intelligence: 21,
                         memory: 22,
                         perception: 23,
                         willpower: 24,
                         security_status: 1.8)

      get "/api/characters/#{ character.character_id }", headers: { 'Authorization': "Bearer #{ session.token }" }

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).keys.sort).to eq(['character'])

      expect(JSON.parse(response.body)['character'].keys.sort).to eq(['alliance',
                                                                      'birthday',
                                                                      'charisma',
                                                                      'corporation',
                                                                      'description',
                                                                      'gender',
                                                                      'icon',
                                                                      'id',
                                                                      'intelligence',
                                                                      'memory',
                                                                      'name',
                                                                      'perception',
                                                                      'security_status',
                                                                      'willpower'])

      expect(JSON.parse(response.body)['character']['id']).to eq(123)

      expect(JSON.parse(response.body)['character']['icon']).to eq('https://imageserver.eveonline.com/Character/123_512.jpg')

      expect(JSON.parse(response.body)['character']['name']).to eq('Character name')

      expect(JSON.parse(response.body)['character']['description']).to eq('Character description')

      expect(JSON.parse(response.body)['character']['birthday']).to eq('2010-01-15T15:26:00Z')

      expect(JSON.parse(response.body)['character']['gender']).to eq('male')

      expect(JSON.parse(response.body)['character']['charisma']).to eq(20)

      expect(JSON.parse(response.body)['character']['intelligence']).to eq(21)

      expect(JSON.parse(response.body)['character']['memory']).to eq(22)

      expect(JSON.parse(response.body)['character']['perception']).to eq(23)

      expect(JSON.parse(response.body)['character']['willpower']).to eq(24)

      expect(JSON.parse(response.body)['character']['security_status']).to eq('1.8')

      expect(JSON.parse(response.body)['character']['alliance'].keys.sort).to eq(['id', 'name'])

      expect(JSON.parse(response.body)['character']['alliance']['id']).to eq(1234)

      expect(JSON.parse(response.body)['character']['alliance']['name']).to eq('Alliance name')

      expect(JSON.parse(response.body)['character']['corporation'].keys.sort).to eq(['id', 'name'])

      expect(JSON.parse(response.body)['character']['corporation']['id']).to eq(12_345)

      expect(JSON.parse(response.body)['character']['corporation']['name']).to eq('Corporation name')
    end
  end
end
