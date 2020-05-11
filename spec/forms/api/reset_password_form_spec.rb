# frozen_string_literal: true

require "rails_helper"

describe Api::ResetPasswordForm, type: :model do
  # it { should be_an(ActiveModel::Model) }
  #
  # describe "validations" do
  #   let!(:user) do
  #     create(:user,
  #       email: "me@example.com",
  #       password: "old_password",
  #       reset_password_token: "reset-token-123")
  #   end
  #
  #   let(:params) do
  #     {
  #       reset_password_token: "reset-token-123",
  #       password: "new_password",
  #       password_confirmation: "new_password",
  #     }
  #   end
  #
  #   subject { described_class.new(params) }
  #
  #   it { should validate_presence_of(:reset_password_token) }
  #
  #   it { should validate_presence_of(:password) }
  #
  #   it { should validate_presence_of(:password_confirmation) }
  #
  #   it { should validate_confirmation_of(:password) }
  # end
  #
  # it { should delegate_method(:id).to(:session) }
  #
  # it { should delegate_method(:token).to(:session) }
  #
  # describe "#save" do
  #   context "when everything ok" do
  #     let!(:user) do
  #       create(:user,
  #         email: "me@example.com",
  #         password: "old_password",
  #         reset_password_token: "reset-token-123")
  #     end
  #
  #     let(:params) do
  #       {
  #         reset_password_token: "reset-token-123",
  #         password: "new_password",
  #         password_confirmation: "new_password",
  #       }
  #     end
  #
  #     subject(:form) { described_class.new(params) }
  #
  #     before do
  #       #
  #       # Api::EndAllUserSessions.new(user).execute
  #       #
  #       expect(Api::EndAllUserSessions).to receive(:new).with(user) do
  #         double.tap do |a|
  #           expect(a).to receive(:execute)
  #         end
  #       end
  #     end
  #
  #     specify { expect(form.save).to eq(true) }
  #
  #     specify { expect { form.save }.to change { user.reload.authenticate("old_password") }.from(user).to(false) }
  #
  #     specify { expect { form.save }.to change { user.reload.authenticate("new_password") }.from(false).to(user) }
  #
  #     specify { expect { form.save }.to change { user.sessions.count }.by(1) }
  #
  #     # specify { expect { form.save }.to change { user.sessions.first&.name }.to('My Computer') }
  #     #
  #     # specify { expect { form.save }.to change { user.sessions.first&.device_type }.to('ios') }
  #     #
  #     # specify { expect { form.save }.to change { user.sessions.first&.device_token }.to('token123') }
  #   end
  #
  #   context "when user reset password token not found" do
  #     let!(:user) do
  #       create(:user,
  #         email: "me@example.com",
  #         password: "old_password",
  #         reset_password_token: "reset-token-123")
  #     end
  #
  #     let(:params) do
  #       {
  #         reset_password_token: "another-reset-token-123",
  #         password: "new_password",
  #         password_confirmation: "new_password",
  #       }
  #     end
  #
  #     subject(:form) { described_class.new(params) }
  #
  #     before { expect(Api::EndAllUserSessions).not_to receive(:new) }
  #
  #     specify { expect(form.save).to eq(false) }
  #
  #     specify { expect { form.save }.to change { form.errors.messages }.from({}).to(base: ["Reset password token not found"]) }
  #   end
  # end
end
