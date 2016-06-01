require 'rails_helper'

describe UserDecorator do
  describe '#as_json' do
    let(:user) do
      stub_model User,
                 id: 42,
                 email: 'me@example.com',
                 token: 'token123'
    end

    subject { user.decorate.as_json }

    its([:id]) { should eq(42) }

    its([:email]) { should eq('me@example.com') }

    its([:token]) { should eq('token123') }
  end
end
