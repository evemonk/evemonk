# frozen_string_literal: true

require 'rails_helper'

module Api
  describe SignUpsController do
    it { should be_a(Api::BaseController) }

    it { should_not use_before_action(:authenticate!) }

    describe '#create' do
      context 'when user successfully created' do
        let(:session) { instance_double(Session) }

        let(:sign_up) { instance_double(Api::SignUp, session: session, save: true) }

        before do
          #
          # Api::SignUp.new(email: 'me@example.com',
          #                 password: 'password',
          #                 password_confirmation: 'password') => sign_up
          #
          expect(SignUp).to receive(:new).with(permitter(email: 'me@example.com',
                                                         password: 'password',
                                                         password_confirmation: 'password'))
                                         .and_return(sign_up)
        end

        before do
          #
          # SessionDecorator.new(sign_up.session,
          #                      context: { with_token: true })
          expect(SessionDecorator).to receive(:new).with(session, context: { with_token: true })
        end

        before do
          post :create, params: {
            sign_up: {
              email: 'me@example.com',
              password: 'password',
              password_confirmation: 'password'
            },
            format: :json
          }
        end

        it { should respond_with(:ok) }
      end

      context 'when not supported accept type' do
        before do
          post :create, params: {
            sign_up: {
              email: 'me@example.com',
              password: 'password',
              password_confirmation: 'password'
            },
            format: :html
          }
        end

        it { should respond_with(:not_acceptable) }
      end
    end
  end
end
