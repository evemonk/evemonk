require 'rails_helper'

describe Api::SessionsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate) }

  describe '#destroy.json' do
    context 'authorized' do
      let!(:user) { create(:user) }

      let!(:session) { create(:session, user: user) }

      before { sign_in(user) }

      before { delete :destroy, params: { id: session.id, format: :json } }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { delete :destroy, params: { id: '42', format: :json } }

      it { should respond_with(:unauthorized) }
    end

    context 'session not found' do
      let!(:user) { create(:user) }

      before { sign_in(user) }

      before { delete :destroy, params: { id: '9999', format: :json } }

      it { should respond_with(:not_found) }
    end
  end

  # private methods

  describe '#resource' do
    context '@session is set' do
      let!(:session) { create(:session) }

      before { subject.instance_variable_set(:@session, session) }

      specify { expect(subject.send(:resource)).to eq(session) }
    end

    context '@session not set' do
      let!(:session) { create(:session) }

      let(:params) { { id: session.id } }

      before { expect(subject).to receive(:params).and_return(params) }

      specify { expect(subject.send(:resource)).to eq(session) }
    end
  end

  describe '#collection' do
    context '@sessions is set' do
      let(:sessions) { double }

      before { subject.instance_variable_set(:@sessions, sessions) }

      specify { expect(subject.send(:collection)).to eq(sessions) }
    end

    context '@sessions not set' do
      let(:sessions) { double }

      let(:params) { { page: '1' } }

      before { expect(subject).to receive(:params).and_return(params) }

      before do
        #
        # subject.policy_scope(Session)
        #        .order(created_at: :asc)
        #        .page(params[:page])
        #
        expect(subject).to receive(:policy_scope).with(::Session) do
          double.tap do |a|
            expect(a).to receive(:order).with(created_at: :asc) do
              double.tap do |b|
                expect(b).to receive(:page).with(params[:page]).and_return(sessions)
              end
            end
          end
        end
      end

      specify { expect { subject.send(:collection) }.not_to raise_error }

      specify { expect { subject.send(:collection) }.to change { subject.instance_variable_get(:@sessions) }.from(nil).to(sessions) }
    end
  end
end
