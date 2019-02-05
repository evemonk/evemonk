# frozen_string_literal: true

require 'rails_helper'

describe Api::RequestResetPasswordForm, type: :model do
  it { should be_a(ActiveModel::Model) }

  xit { should validate_presence_of(:email) } # TODO: update shoulda-matchers and enable this spec

  describe '#save' do
    context 'when user with given email not found' do
      let(:params) { { email: 'me@example.com' } }

      subject { described_class.new(params) }

      specify { expect(subject.save).to eq(false) }

      specify { expect { subject.save }.to change { subject.errors.messages }.from({}).to(email: ['Email not found']) }
    end

    context 'when user with given email is found' do
      let!(:user) { create(:user, email: 'me@example.com') }

      let(:params) { { email: 'me@example.com' } }

      subject { described_class.new(params) }

      before do
        #
        # UserResetPasswordMailer.with(user: user).email.deliver_later
        #
        expect(UserResetPasswordMailer).to receive(:with).with(user: user) do
          double.tap do |a|
            expect(a).to receive(:email) do
              double.tap do |b|
                expect(b).to receive(:deliver_later)
              end
            end
          end
        end
      end

      specify { expect(subject.save).to eq(true) }

      specify { expect { subject.save }.to change { user.reload.reset_password_token } }
    end

    context 'when user with given email is found (case insensitive)' do
      let!(:user) { create(:user, email: 'me@example.com') }

      let(:params) { { email: 'ME@EXAMPLE.COM' } }

      subject { described_class.new(params) }

      before do
        #
        # UserResetPasswordMailer.with(user: user).email.deliver_later
        #
        expect(UserResetPasswordMailer).to receive(:with).with(user: user) do
          double.tap do |a|
            expect(a).to receive(:email) do
              double.tap do |b|
                expect(b).to receive(:deliver_later)
              end
            end
          end
        end
      end

      specify { expect(subject.save).to eq(true) }

      specify { expect { subject.save }.to change { user.reload.reset_password_token } }
    end
  end
end
