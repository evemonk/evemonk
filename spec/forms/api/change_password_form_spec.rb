# frozen_string_literal: true

require 'rails_helper'

describe Api::ChangePasswordForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  xit { should validate_presence_of(:password) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_presence_of(:password_confirmation) } # TODO: update shoulda-matchers and enable this spec

  xit { should validate_confirmation_of(:password) }

  describe '#save' do
    context 'when user exist and password right' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      let!(:session1) { create(:session, user: user) }

      let!(:session2) { create(:session, user: user) }

      let!(:session3) { create(:session, user: user) }

      let(:params) do
        {
          old_password: 'password',
          password: 'new_password',
          password_confirmation: 'new_password',
          name: 'My Computer',
          device_type: 'ios',
          device_token: 'token123'
        }
      end

      subject { described_class.new(params.merge(user: user)) }

      specify { expect(subject.save).to eq(true) }

      specify { expect { subject.save }.to change { user.sessions.count }.by(-2) }

      specify { expect { subject.save }.to change { user.sessions.first&.token }.from(nil) }

      specify { expect { subject.save }.to change { user.sessions.first&.name }.from(nil).to('My Computer') }

      specify { expect { subject.save }.to change { user.sessions.first&.device_type }.from(nil).to('ios') }

      specify { expect { subject.save }.to change { user.sessions.first&.device_token }.from(nil).to('token123') }

    end
  end
end
