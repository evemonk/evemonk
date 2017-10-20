require 'rails_helper'

describe Api::SessionsController do
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

  describe '#destroy' do
    context 'authorized' do
      context 'owner' do
        let!(:session) { create(:session, id: 42) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { delete :destroy, params: { id: '42', format: :json } }

        it { should respond_with(:ok) }
      end

      context 'not owned' do
        let!(:session) { create(:session, id: 42) }

        let!(:another_session) { create(:session, id: 43) }

        before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

        before { delete :destroy, params: { id: '43', format: :json } }

        it { should respond_with(:forbidden) }
      end
    end

    context 'not authorized' do
      let!(:session) { create(:session, id: 42) }

      before { delete :destroy, params: { id: '42', format: :json } }

      it { should respond_with(:unauthorized) }
    end
  end

  # private methods

  describe '#resource' do
    context '@session not set' do
      let!(:session) { create(:session, id: 42) }

      let(:params) { { id: '42' } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect(subject.send(:resource)).to eq(session) }
    end

    context '@session is set' do
      let!(:session) { double }

      before { subject.instance_variable_set(:@session, session) }

      specify { expect(subject.send(:resource)).to eq(session) }
    end
  end

  describe '#collection' do
    context '@sessions not set' do
      let!(:user) { create(:user) }

      let!(:session1) { create(:session, user: user) }

      let!(:session2) { create(:session, user: user) }

      before { expect(subject).to receive(:current_user).and_return(user) }

      specify { expect(subject.send(:collection)).to eq([session1, session2]) }

      specify { expect { subject.send(:collection) }.to change { subject.instance_variable_get(:@sessions) }.from(nil) }
    end

    context '@sessions is set' do
      let(:sessions) { double }

      before { subject.instance_variable_set(:@sessions, sessions) }

      specify { expect(subject.send(:collection)).to eq(sessions) }
    end
  end
end
