# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController do
  describe '#index' do
    it 'returns list of user characters' do
      user = create(:user)

      session = create(:session, user: user)

      character = create(:character,
                         user: user)

      get '/api/characters', headers: { 'Authorization': "Bearer #{ session.token }" }

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq('total_count' => 0,
                                              'total_pages' => 0,
                                              'current_page' => 1,
                                              'characters' => [])
    end
  end
end
