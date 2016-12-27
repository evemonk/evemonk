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

      before { expect(subject).not_to receive(:create_secure_token!) }

      specify { expect { subject.save! }.to raise_error ActiveModel::StrictValidationFailed }
    end

    context 'valid' do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:create_secure_token!) }

      specify { expect { subject.save! }.not_to raise_error }
    end
  end

  describe '#decorate' do
    before do
      #
      # subject.secure_token.decorate
      #
      expect(subject).to receive(:secure_token) do
        double.tap do |a|
          expect(a).to receive(:decorate)
        end
      end
    end

    specify { expect { subject.decorate }.not_to raise_error }
  end

  # private methods

  describe '#user' do
    context 'user not set' do
      let(:user) { double }

      let(:email) { double }

      before { expect(subject).to receive(:email).and_return(email) }

      before do
        #
        # User.where('LOWER(email) = LOWER(?)', email).first
        #
        expect(User).to receive(:where).with('LOWER(email) = LOWER(?)', email) do
          double.tap do |a|
            expect(a).to receive(:first)
          end
        end
      end

      specify { expect { subject.send(:user) }.not_to raise_error }
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

  describe '#create_secure_token!' do
    context '@secure_token is set' do
      let(:secure_token) { double }

      before { subject.instance_variable_set(:@secure_token, secure_token) }

      specify { expect(subject.send(:create_secure_token!)).to eq(secure_token) }
    end

    context '@secure_token not set' do
      before do
        #
        # subject.user.secure_tokens.create!
        #
        expect(subject).to receive(:user) do
          double.tap do |a|
            expect(a).to receive(:secure_tokens) do
              double.tap do |b|
                expect(b).to receive(:create!)
              end
            end
          end
        end
      end

      specify { expect { subject.send(:create_secure_token!) }.not_to raise_error }
    end
  end
end
