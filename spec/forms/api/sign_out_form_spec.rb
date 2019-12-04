# frozen_string_literal: true

require "rails_helper"

describe Api::SignOutForm do
  let(:request) { double } # TODO: use instance_double

  subject { described_class.new(request) }

  it { should be_a(ActionController::HttpAuthentication::Token) }

  describe "#destroy!" do
    let!(:user) { create(:user) }

    let!(:session) { create(:session, user: user) }

    before do
      #
      # subject.token_and_options(request) => [token]
      #
      expect(subject).to receive(:token_and_options).with(request)
        .and_return([session.token])
    end

    specify { expect { subject.destroy! }.to change { user.sessions.count }.by(-1) }
  end
end
