# frozen_string_literal: true

require 'rails_helper'

module Api
  describe BaseController do
    it { should be_a(ApplicationController) }

    it { should be_a(Pundit) }

    it { should use_before_action(:authenticate!) }

    describe '#current_user' do
      let!(:user) { instance_double(User) }

      before { subject.instance_variable_set(:@current_user, user) }

      specify { expect(subject.current_user).to eq(user) }
    end

    it { should rescue_from(ActiveRecord::RecordNotFound) }

    it { should rescue_from(ActionController::UnknownFormat) }

    it { should rescue_from(Pundit::NotAuthorizedError) }

    # private methods

    describe '#authenticate!' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      before { expect(subject).to receive(:authenticate_or_request_with_http_token).and_yield(session.token) }

      specify { expect(subject.send(:authenticate!)).to eq(user) }
    end

    describe '#authenticate' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      before { expect(subject).to receive(:authenticate_with_http_token).and_yield(session.token) }

      specify { expect(subject.send(:authenticate)).to eq(user) }
    end
  end
end
