require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Api::ProfilesController do
  it { should use_before_action(:authenticate!) }

  describe '#show.json' do
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
  end

  describe '#show.html' do
    context 'authorized' do
      let!(:session) { create(:session) }

      before { request.env['HTTP_AUTHORIZATION'] = "Bearer #{ session.token }" }

      before { get :show, format: :html }

      it { should respond_with(:not_acceptable) }
    end

    context 'not authorized' do
      before { get :show, format: :html }

      it { should respond_with(:unauthorized) }
    end
  end

  # private methods

  describe '#resource' do
    context '@profile is set' do
      let(:user) { create(:user) }

      before { subject.instance_variable_set(:@profile, user) }

      specify { expect(subject.send(:resource)).to eq(user) }
    end

    context '@profile not set' do
      let(:current_user) { create(:user) }

      before { expect(subject).to receive(:current_user).and_return(current_user) }

      specify { expect(subject.send(:resource)).to eq(current_user) }

      specify { expect { subject.send(:resource) }.to change { subject.instance_variable_get(:@profile) }.from(nil).to(current_user) }
    end
  end
end
