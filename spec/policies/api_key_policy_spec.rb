require 'rails_helper'

describe ApiKeyPolicy do
  context 'owner' do
    let(:user) { stub_model User, id: 42 }

    let(:api_key) { stub_model ApiKey, user_id: 42 }

    before { allow(user).to receive(:api_keys).and_return([api_key]) }

    subject { ApiKeyPolicy.new(user, api_key) }

    specify { should permit_action(:create) }

    specify { should permit_action(:show) }

    specify { should permit_action(:destroy) }

    specify { should forbid_action(:update) }
  end



  # [:index, :create, :show, :destroy]

  # context 'not owner' do
  #
  # end
  #
  #
  # let(:user) { stub_model User }
  #
  # let(:api_key) { stub_model ApiKey }
  #
  # subject { ApiKeyPolicy.new(user, api_key) }
  #
  # it { should permit_action(:show) }
  #
  # it { should permit_action(:show) }
  #
  # it { should permit_action(:destroy) }
end
