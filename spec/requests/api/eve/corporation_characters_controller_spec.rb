# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::CorporationCharactersController do
  describe '#index' do
    it 'returns list of Eve Corporation Characters' do

    end

    it 'returns 404' do
      get '/api/eve/corporations/123/characters'

      expect(response).to have_http_status(:not_found)
    end
  end
end
