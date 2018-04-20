# frozen_string_literal: true

require 'rails_helper'

module Api
  describe SignInsController do
    it { should be_a(Api::BaseController) }

    it { should_not use_before_action(:authenticate!) }

    describe '#create' do
      context 'when user successful authorize' do
        let(:session) { instance_double(Session) }

        let(:sign_in) { instance_double(Api::SignIn, session: session, save: true) }

        before do
          #
          # Api::SignIn.new(email: 'me@example.com',
          #                 password: 'password',
          #                 name: 'iOS session',
          #                 device_type: 'ios',
          #                 device_token: 'token123') => sign_in
          #
          expect(Api::SignIn).to receive(:new).with(permitter(email: 'me@example.com',
                                                              password: 'password',
                                                              name: 'iOS session',
                                                              device_type: 'ios',
                                                              device_token: 'token123'))
                                              .and_return(sign_in)
        end

        before do
          #
          # SessionDecorator.new(sign_in.session,
          #                      context: { with_token: true })
          expect(SessionDecorator).to receive(:new).with(session, context: { with_token: true })
        end

        before do
          post :create, params: {
            sign_in: {
              email: 'me@example.com',
              password: 'password',
              name: 'iOS session',
              device_type: 'ios',
              device_token: 'token123'
            },
            format: :json
          }
        end

        it { should respond_with(:ok) }
      end

      context 'when user not successful authorize' do
        let(:errors) { double }

        let(:sign_in) { instance_double(Api::SignIn, errors: errors, save: false) }

        before do
          #
          # Api::SignIn.new(email: 'me@example.com',
          #                 password: 'password',
          #                 name: 'iOS session',
          #                 device_type: 'ios',
          #                 device_token: 'token123') => sign_in
          #
          expect(Api::SignIn).to receive(:new).with(permitter(email: 'me@example.com',
                                                              password: 'password',
                                                              name: 'iOS session',
                                                              device_type: 'ios',
                                                              device_token: 'token123'))
                                              .and_return(sign_in)
        end

        before do
          post :create, params: {
            sign_in: {
              email: 'me@example.com',
              password: 'password',
              name: 'iOS session',
              device_type: 'ios',
              device_token: 'token123'
            },
            format: :json
          }
        end

        it { should respond_with(:unprocessable_entity) }
      end

      context 'when not supported accept type' do
        before do
          post :create, params: {
            sign_in: {
              email: 'me@example.com',
              password: 'password',
              name: 'iOS session',
              device_type: 'ios',
              device_token: 'token123'
            },
            format: :html
          }
        end

        it { should respond_with(:not_acceptable) }
      end
    end
  end
end
