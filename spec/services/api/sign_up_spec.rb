# frozen_string_literal: true

require 'rails_helper'

describe Api::SignUp, type: :model do
  let(:params) do
    {
      email: 'me@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  subject { described_class.new(params) }

  it { should be_a(ActiveModel::Validations) }

  it { should delegate_method(:decorate).to(:session) }

  it { should validate_presence_of(:email) }

  it { should validate_presence_of(:password) }

  it { should validate_confirmation_of(:password) }

  describe '#initialize' do
    specify { expect(subject.email).to eq('me@example.com') }

    specify { expect(subject.password).to eq('password') }

    specify { expect(subject.password_confirmation).to eq('password') }
  end

  describe '#save' do
    context 'user valid' do
      specify { expect { subject.save }.to change { User.count }.from(0).to(1) }

      specify { expect { subject.save }.to change { Session.count }.from(0).to(1) }
    end

    context 'user not valid' do
      let(:params) do
        {
          email: nil,
          password: nil
        }
      end

      specify { expect(subject.save).to eq(false) }
    end

    context 'user valid but email has already been taken' do
      let!(:existed_user) { create(:user, email: 'me@example.com') }

      specify do
        expect { subject.save }.to raise_error(ActiveModel::StrictValidationFailed) do
          expect(subject.errors[:email]).to eq(['has already been taken'])
        end
      end
    end
  end
end
