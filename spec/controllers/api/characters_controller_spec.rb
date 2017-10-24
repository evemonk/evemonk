# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate!) }

  describe '#index' do
    context 'authorized' do
      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :index, format: :json }

      it { should render_template(:index) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { get :index, format: :json }

      it { should respond_with(:unauthorized) }
    end

    context 'not supported accept:' do
      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :index, format: :html }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe '#show' do
    context 'authorized' do
      context 'owner' do
        let!(:user) { create(:user) }

        let!(:session) { create(:session, user: user) }

        let!(:character) { create(:character, user: user, id: 123) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { get :show, params: { id: '123', format: :json } }

        it { should render_template(:show) }

        it { should respond_with(:ok) }
      end

      context 'not owned' do
        let!(:user) { create(:user) }

        let!(:session) { create(:session, user: user) }

        let!(:character) { create(:character, id: 123) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { get :show, params: { id: '123', format: :json } }

        it { should respond_with(:forbidden) }
      end
    end

    context 'not authorized' do
      let!(:character) { create(:character, id: 123) }

      before { get :show, params: { id: '123', format: :json } }

      it { should respond_with(:unauthorized) }
    end

    context 'not supported accept:' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:character) { create(:character, user: user, id: 123) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, params: { id: '123', format: :html } }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe '#destroy' do
    context 'authorized' do
      context 'owned' do
        let!(:user) { create(:user) }

        let!(:session) { create(:session, user: user) }

        let!(:character) { create(:character, user: user, id: 123) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { delete :destroy, params: { id: '123', format: :json } }

        it { should respond_with(:no_content) }
      end

      context 'not owned' do
        let!(:user) { create(:user) }

        let!(:session) { create(:session, user: user) }

        let!(:character) { create(:character, id: 123) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { delete :destroy, params: { id: '123', format: :json } }

        it { should respond_with(:forbidden) }
      end
    end

    context 'not authorized' do
      let!(:character) { create(:character, id: 123) }

      before { delete :destroy, params: { id: '123', format: :json } }

      it { should respond_with(:unauthorized) }
    end
  end

  # private methods

  describe '#resource' do
    context '@character not set' do
      let!(:character) { create(:character, id: 123) }

      let(:params) { { id: '123' } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect(subject.send(:resource)).to eq(character) }

      specify { expect { subject.send(:resource) }.to change { subject.instance_variable_get(:@character) }.from(nil).to(character) }
    end

    context '@character is set' do
      let(:character) { double }

      before { subject.instance_variable_set(:@character, character) }

      specify { expect(subject.send(:resource)).to eq(character) }
    end
  end

  describe '#collection' do
    context '@characters not set' do
      let!(:user) { create(:user) }

      let!(:character1) { create(:character, user: user) }

      let!(:character2) { create(:character, user: user) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      specify { expect(subject.send(:collection)).to eq([character1, character2]) }

      specify { expect { subject.send(:collection) }.to change { subject.instance_variable_get(:@characters) }.from(nil) }
    end

    context '@characters is set' do
      let(:characters) { double }

      before { subject.instance_variable_set(:@characters, characters) }

      specify { expect(subject.send(:collection)).to eq(characters) }
    end
  end
end
