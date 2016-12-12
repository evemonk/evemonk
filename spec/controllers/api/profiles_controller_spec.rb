require 'rails_helper'

describe Api::ProfilesController do
  describe '#show.json' do
    context 'authorized' do
      before { expect(subject).to receive(:verify_authorized).and_return(true) }

      let(:user) { double }

      before { expect(subject).to receive(:resource).and_return(user) }

      before { expect(subject).to receive(:authorize).with(user) }

      before { sign_in }

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
    let(:current_user) { double }

    before { expect(subject).to receive(:current_user).and_return(current_user) }

    specify { expect(subject.send(:resource)).to eq(current_user) }
  end
end
