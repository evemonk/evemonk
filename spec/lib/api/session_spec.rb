require 'rails_helper'

describe Api::Session do
  it { should be_a(ActiveModel::Validations) }

  describe '#initialize' do
    let(:params) do
      {
        email: 'me@example.com',
        password: 'password'
      }
    end

    subject { described_class.new(params) }

    its(:email) { should eq('me@example.com') }

    its(:password) { should eq('password') }
  end

  describe '#save!' do
    context 'not valid' do
      before { expect(subject).to receive(:valid?).and_return(false) }

      specify { expect { subject.save! }.to raise_error ActiveModel::StrictValidationFailed }
    end

    context 'valid' do
      before { expect(subject).to receive(:valid?).and_return(true) }

      specify { expect { subject.save! }.not_to raise_error }
    end
  end

  describe '#decorate' do
    let(:user) { double }

    before { expect(subject).to receive(:user).and_return(user) }

    before { expect(UserDecorator).to receive(:new).with(user) }

    specify { expect { subject.decorate }.not_to raise_error }
  end

  # private methods

  describe '#user' do
    let(:user) { double }

    let(:email) { double }

    before { expect(subject).to receive(:email).and_return(email) }

    before { expect(User).to receive(:find_by).with(email: email).and_return(user) }

    specify { expect { subject.send(:user) }.not_to raise_error }
  end

  describe '#user_presence' do
    context 'user not found' do
      before { expect(subject).to receive(:user).and_return(nil) }

      before { subject.send(:user_presence) }

      specify { expect(subject.errors[:email]).to eq(['not found']) }
    end

    context 'user found' do
      let(:user) { double }

      before { expect(subject).to receive(:user).and_return(user) }

      before { subject.send(:user_presence) }

      specify { expect(subject.errors[:email]).to eq([]) }
    end
  end

  describe '#user_password' do
    context 'user not found' do
      before { expect(subject).to receive(:user).and_return(nil) }

      specify { expect(subject.send(:user_password)).to eq(nil) }
    end

    context 'user found but password is invalid' do
      let(:user) { double }

      let(:password) { double }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(subject).to receive(:password).and_return(password) }

      before { expect(user).to receive(:authenticate).with(password).and_return(false) }

      before { subject.send(:user_password) }

      specify { expect(subject.errors[:password]).to eq(['is invalid']) }
    end

    context 'user found and password is valid' do
      let(:user) { double }

      let(:password) { double }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(subject).to receive(:password).and_return(password) }

      before { expect(user).to receive(:authenticate).with(password).and_return(true) }

      before { subject.send(:user_password) }

      specify { expect(subject.errors[:password]).to eq([]) }
    end
  end
end
