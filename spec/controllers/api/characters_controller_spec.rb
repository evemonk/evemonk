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
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:character) { create(:character, user: user, id: 123) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, params: { id: '123', format: :json } }

      it { should render_template(:show) }

      it { should respond_with(:ok) }
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

    context 'not found' do
      render_views

      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      let!(:character) { create(:character, id: 123) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, params: { id: '123', format: :json } }

      it { should respond_with(:not_found) }
    end
  end

  describe '#destroy' do
  end

  # private methods

  describe '#resource' do
    context 'found' do
      let!(:user) { create(:user) }

      let!(:character) { create(:character, user: user, id: 123) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      let(:params) { { id: '123' } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect(subject.send(:resource)).to eq(character) }

      specify { expect { subject.send(:resource) }.to change { subject.instance_variable_get(:@character) }.from(nil).to(character) }
    end

    context 'not found' do
      let!(:user) { create(:user) }

      let!(:character) { create(:character, id: 123) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      let(:params) { { id: '123' } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect { subject.send(:resource) }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'memoization' do
      let(:character) { double }

      before { subject.instance_variable_set(:@character, character) }

      specify { expect(subject.send(:resource)).to eq(character) }
    end
  end

  describe '#collection' do
    let!(:user) { create(:user) }

    let!(:character1) { create(:character, user: user) }

    let!(:character2) { create(:character, user: user) }

    before { expect(subject).to receive(:current_user).and_return(user) }

    specify { expect(subject.send(:collection)).to eq([character1, character2]) }

    specify { expect { subject.send(:collection) }.to change { subject.instance_variable_get(:@characters) }.from(nil) }
  end
end
