require 'rails_helper'

describe Api::SignInsController do
  describe 'routing' do
    it 'should route POST /api/sign_in to api/sign_ins#create' do
      expect(post: '/api/sign_in').to route_to(
        controller: 'api/sign_ins',
        action: 'create',
        format: 'json'
      )
    end
  end
end
