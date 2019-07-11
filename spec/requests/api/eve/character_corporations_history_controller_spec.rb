# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CharacterCorporationsHistoryController do
  describe '#index' do
    it 'returns Eve Character corporation history' do
      create(:eve_character,
             character_id: 123)

      get '/api/eve/characters/123/corporations_history'

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('current_page' => 1,
                                              'total_count' => 0,
                                              'total_pages' => 0)
    end
  end
end
