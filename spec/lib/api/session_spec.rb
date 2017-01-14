require 'rails_helper'

describe Api::Session do
  it { should be_a(ActiveModel::Validations) }

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
    context 'not valid' do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(subject).not_to receive(:create_session!) }

      specify { expect { subject.save! }.to raise_error ActiveModel::StrictValidationFailed }
    end

    context 'valid' do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:create_session!) }

      specify { expect { subject.save! }.not_to raise_error }
    end
  end

  describe '#decorate' do
    let(:args) { double }

    before do
      #
      # subject.session.decorate(*args)
      #
      expect(subject).to receive(:session) do
        double.tap do |a|
          expect(a).to receive(:decorate).with(*args)
        end
      end
    end

    specify { expect { subject.decorate(*args) }.not_to raise_error }
  end

  # private methods

  describe '#user' do
    context 'user not set' do
      let!(:user) { create(:user, email: 'igor.zubkov@gmail.com') }

      let(:params) { { email: 'Igor.Zubkov@gmail.com' } }

      subject { described_class.new(params) }

      specify { expect(subject.send(:user)).to eq(user) }
    end

    context 'user is set' do
      let(:user) { double }

      before { subject.instance_variable_set(:@user, user) }

      specify { expect(subject.send(:user)).to eq(user) }
    end
  end

  describe '#user_presence' do
    context 'user not found' do
      before { expect(subject).to receive(:user).and_return(nil) }

      before { subject.send(:user_presence) }

      specify { expect(subject.errors[:base]).to eq(['Email and/or password is invalid']) }
    end

    context 'user found' do
      let(:user) { double }

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
      let(:user) { double }

      let(:password) { double }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(subject).to receive(:password).and_return(password) }

      before { expect(user).to receive(:authenticate).with(password).and_return(false) }

      before { subject.send(:user_password) }

      specify { expect(subject.errors[:base]).to eq(['Email and/or password is invalid']) }
    end

    context 'user found and password is valid' do
      let(:user) { double }

      let(:password) { double }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(subject).to receive(:password).and_return(password) }

      before { expect(user).to receive(:authenticate).with(password).and_return(true) }

      before { subject.send(:user_password) }

      specify { expect(subject.errors[:base]).to eq([]) }
    end
  end

  describe '#create_session!' do
    context '@session is set' do
      let(:session) { double }

      before { subject.instance_variable_set(:@session, session) }

      specify { expect(subject.send(:create_session!)).to eq(session) }
    end

    context '@session not set' do
      let(:name) { double }

      let(:device) { double }

      let(:device_token) { double }

      before { expect(subject).to receive(:name).and_return(name) }

      before { expect(subject).to receive(:device).and_return(device) }

      before { expect(subject).to receive(:device_token).and_return(device_token) }

      before do
        #
        # subject.user.sessions.create!(name: name,
        #                               device: device,
        #                               device_token: device_token)
        #
        expect(subject).to receive(:user) do
          double.tap do |a|
            expect(a).to receive(:sessions) do
              double.tap do |b|
                expect(b).to receive(:create!).with(name: name,
                                                    device: device,
                                                    device_token: device_token)
              end
            end
          end
        end
      end

      specify { expect { subject.send(:create_session!) }.not_to raise_error }
    end
  end
end
