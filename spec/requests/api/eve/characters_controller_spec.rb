# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CharactersController do
  describe '#index' do
    it 'returns list of Eve Characters' do
      create(:eve_character,
             character_id: 123,
             birthday: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             description: 'character description',
             gender: 'male',
             name: 'character name',
             security_status: 1.1,
             title: 'character title')

      get '/api/eve/characters'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 1,
                                              'total_pages' => 1,
                                              'current_page' => 1,
                                              'characters' => [{
                                                'icon' => 'https://imageserver.eveonline.com/Character/123_512.jpg',
                                                'id' => 123,
                                                'birthday' => '2015-05-03T19:45:17Z',
                                                'description' => 'character description',
                                                'gender' => 'male',
                                                'name' => 'character name',
                                                'security_status' => '1.1',
                                                'title' => 'character title'
                                             }])
    end
  end

  describe '#show' do
    it 'returns Eve Character' do
      create(:eve_character,
             character_id: 123,
             birthday: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             description: 'character description',
             gender: 'male',
             name: 'character name',
             security_status: 1.1,
             title: 'character title')

      get '/api/eve/characters/123'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('character' => {
                                                'icon' => 'https://imageserver.eveonline.com/Character/123_512.jpg',
                                                'id' => 123,
                                                'birthday' => '2015-05-03T19:45:17Z',
                                                'description' => 'character description',
                                                'gender' => 'male',
                                                'name' => 'character name',
                                                'security_status' => '1.1',
                                                'title' => 'character title'
                                             })
    end

    it 'returns 404' do
      get '/api/eve/characters/456'

      expect(response).to have_http_status(:not_found)
    end
  end
end
