require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Api::SignIn do
  it { should be_a(ActiveModel::Validations) }

  it { should delegate_method(:decorate).to(:session) }

  describe '#initialize' do
    let(:params) do
      {
        email: 'me@example.com',
        password: 'password',
        name: 'My Computer',
        device: 'ios',
        device_token: 'token123'
      }
    end

    subject { described_class.new(params) }

    its(:email) { should eq('me@example.com') }

    its(:password) { should eq('password') }

    its(:name) { should eq('My Computer') }

    its(:device) { should eq('ios') }

    its(:device_token) { should eq('token123') }
  end

  describe '#save!' do
    let!(:user) { create(:user, password: 'password') }

    context 'not valid' do
      let(:params) { { email: user.email, password: 'wrong password' } }

      subject { described_class.new(params) }

      specify { expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed) }
    end

    context 'valid' do
      let(:params) { { email: user.email, password: 'password' } }

      subject { described_class.new(params) }

      specify { expect { subject.save! }.not_to raise_error }

      specify { expect { subject.save! }.to change { Session.count }.from(0).to(1) }
    end
  end

  # private methods

  describe '#user' do
    let!(:user) { create(:user, email: 'igor.zubkov@gmail.com') }

    let(:params) { { email: 'Igor.Zubkov@gmail.com' } }

    subject { described_class.new(params) }

    specify { expect(subject.send(:user)).to eq(user) }

    specify { expect { subject.send(:user) }.to change { subject.instance_variable_get(:@user) }.from(nil).to(user) }
  end

  describe '#user_presence' do
    context 'user not found' do
      before { expect(subject).to receive(:user).and_return(nil) }

      before { subject.send(:user_presence) }

      specify { expect(subject.errors[:base]).to eq(['Email and/or password is invalid']) }
    end

    context 'user found' do
      let!(:user) { create(:user) }

      before { expect(subject).to receive(:user).and_return(user) }

      before { subject.send(:user_presence) }

      specify { expect(subject.errors[:base]).to eq([]) }
    end
  end

  describe '#user_password' do
    context 'user not found' do
      before { expect(subject).to receive(:user).and_return(nil) }

      specify { expect(subject.send(:user_password)).to eq(nil) }
    end

    context 'user found but password is invalid' do
      let!(:user) { create(:user, password: 'password') }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(subject).to receive(:password).and_return('wrong password') }

      before { subject.send(:user_password) }

      specify { expect(subject.errors[:base]).to eq(['Email and/or password is invalid']) }
    end

    context 'user found and password is valid' do
      let(:user) { create(:user, password: 'password') }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(subject).to receive(:password).and_return('password') }

      before { subject.send(:user_password) }

      specify { expect(subject.errors[:base]).to eq([]) }
    end
  end

  describe '#create_session!' do
    context '@session is set' do
      let!(:session) { create(:session) }

      before { subject.instance_variable_set(:@session, session) }

      specify { expect(subject.send(:create_session!)).to eq(session) }
    end

    context '@session not set' do
      let!(:user) { create(:user) }

      let(:params) do
        {
          email: 'me@example.com',
          password: 'password',
          name: 'My Computer',
          device: 'ios',
          device_token: 'token123'
        }
      end

      subject { described_class.new(params) }

      before { expect(subject).to receive(:user).and_return(user) }

      specify { expect { subject.send(:create_session!) }.to change { user.sessions.count }.from(0).to(1) }

      specify { expect(subject.send(:create_session!).name).to eq('My Computer') }

      specify { expect(subject.send(:create_session!).device).to eq('ios') }

      specify { expect(subject.send(:create_session!).device_token).to eq('token123') }
    end
  end
end
