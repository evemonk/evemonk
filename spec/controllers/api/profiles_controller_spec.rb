# frozen_string_literal: true
require 'rails_helper'

describe Api::ProfilesController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate!) }

  describe '#show' do
    context 'authorized' do
      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, format: :json }

      it { should render_template(:show) }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { get :show, format: :json }

      it { should respond_with(:unauthorized) }
    end

    context 'not supported accept:' do
      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, format: :html }

      it { should respond_with(:not_acceptable) }
    end
  end

  # private methods

  describe '#resource' do
    let(:current_user) { create(:user) }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    specify { expect(subject.send(:resource)).to eq(current_user) }
  end
end
