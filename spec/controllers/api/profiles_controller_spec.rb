require 'rails_helper'

describe Api::ProfilesController do
  it { should use_before_action(:authenticate) }

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

  # private methods

  describe '#resource' do
    context '@profile is set' do
      let(:profile) { create(:user) }

      before { subject.instance_variable_set(:@profile, profile) }

      specify { expect(subject.send(:resource)).to eq(profile) }
    end

    context '@profile not set' do
      let(:current_user) { create(:user) }

      before { expect(subject).to receive(:current_user).and_return(current_user) }

      specify { expect(subject.send(:resource)).to eq(current_user) }

      specify { expect { subject.send(:resource) }.to change { subject.instance_variable_get(:@profile) }.from(nil).to(current_user) }
    end
  end
end
