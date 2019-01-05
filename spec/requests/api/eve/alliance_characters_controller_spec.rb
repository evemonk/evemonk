# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AllianceCharactersController do
  describe '#index' do
    it 'returns list of Eve Alliance Characters' do
      create(:eve_alliance,
             alliance_id: 123)

      get '/api/eve/alliances/123/characters'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 0,
                                              'total_pages' => 0,
                                              'current_page' => 1,
                                              'characters' => [])
    end
  end
end
