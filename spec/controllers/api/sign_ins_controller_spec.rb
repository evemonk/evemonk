# frozen_string_literal: true

require 'rails_helper'

module Api
  describe SignInsController do
    it { should be_a(Api::BaseController) }

    it { should_not use_before_action(:authenticate!) }

    describe '#create' do


      context 'when not supported accept type' do
        before do
          post :create, params: {
            sign_in: {
              email: 'me@example.com',
              password: 'password'
            },
            format: :html
          }
        end

        it { should respond_with(:not_acceptable) }
      end
    end
  end
end
