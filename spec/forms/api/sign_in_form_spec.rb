# frozen_string_literal: true

require 'rails_helper'

describe Api::SignInForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  it { should validate_presence_of(:email) }

  it { should validate_presence_of(:password) }

  describe '#save' do
    context 'when user exist and password right' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      let(:params) do
        {
          email: 'me@example.com',
          password: 'password',
          name: 'My Computer',
          device_type: 'ios',
          device_token: 'token123'
        }
      end

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(true) }

      specify { expect { subject.save }.to change { user.sessions.count }.by(1) }

      specify { expect { subject.save }.to change { user.sessions.first&.token }.from(nil) }

      specify { expect { subject.save }.to change { user.sessions.first&.name }.from(nil).to('My Computer') }

      specify { expect { subject.save }.to change { user.sessions.first&.device_type }.from(nil).to('ios') }

      specify { expect { subject.save }.to change { user.sessions.first&.device_token }.from(nil).to('token123') }
    end

    context 'when user exist but password wrong' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      let(:params) { { email: 'me@example.com', password: 'wrong password' } }

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to change { subject.errors.messages }.from({}).to(base: ['Email and/or password is invalid']) }

      specify { expect { subject.save }.not_to change { user.sessions.count } }
    end

    context 'when user not exists' do
      let(:params) { { email: 'me@example.com', password: 'password' } }

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to change { subject.errors.messages }.from({}).to(base: ['Email and/or password is invalid']) }

      specify { expect { subject.save }.not_to change { Session.count } }
    end
  end
end
