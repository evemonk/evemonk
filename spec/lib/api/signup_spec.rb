require 'rails_helper'

describe Api::Signup do
  describe '#initialize' do
    context 'without params' do
      specify { expect(subject.params).to eq({}) }
    end

    context 'with params' do
      let(:params) { double }

      subject { described_class.new(params) }

      specify { expect(subject.params).to eq(params) }
    end
  end

  describe '#save!' do
    context 'user valid' do
      let(:user) { double }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before { expect(user).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:build_secure_token) }

      before { expect(user).to receive(:save!) }

      specify { expect { subject.save! }.not_to raise_error }
    end

    context 'user not valid' do
      let(:user) { double }

      before { expect(subject).to receive(:user).and_return(user) }

      before { expect(user).to receive(:valid?).and_return(false) }

      before { expect(subject).not_to receive(:build_secure_token) }

      before { expect(user).not_to receive(:save!) }

      specify { expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed) }
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

  describe '#user' do
    context 'user not set' do
      let(:params) { double }

      subject { described_class.new(params) }

      before do
        #
        # User.new(params)
        #
        expect(User).to receive(:new).with(params)
      end

      specify { expect { subject.user }.not_to raise_error }
    end

    context 'user is set' do
      let(:user) { double }

      before { subject.instance_variable_set(:@user, user) }

      specify { expect(subject.user).to eq(user) }
    end
  end

  describe '#errors' do
    before do
      #
      # subject.user.errors
      #
      expect(subject).to receive(:user) do
        double.tap do |a|
          expect(a).to receive(:errors)
        end
      end
    end

    specify { expect { subject.errors }.not_to raise_error }
  end

  describe '#build_secure_token' do
    context 'secure_token not set' do
      let(:user) { double }

      before { expect(subject).to receive(:user).and_return(user) }

      before do
        #
        # user.secure_tokens.build
        #
        expect(user).to receive(:secure_tokens) do
          double.tap do |a|
            expect(a).to receive(:build)
          end
        end
      end

      specify { expect { subject.build_secure_token }.not_to raise_error }
    end

    context 'secure_token is set' do
      let(:secure_token) { double }

      before { subject.instance_variable_set(:@secure_token, secure_token) }

      specify { expect(subject.build_secure_token).to eq(secure_token) }
    end
  end
end
