# frozen_string_literal: true
require 'rails_helper'

describe MainController do
  describe 'routing' do
    it 'should route / to main#index' do
      expect(get: '/').to route_to('main#index')
    end
  end
end
