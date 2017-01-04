require 'rails_helper'

describe Api::SessionsController do
  it { should be_a(Api::BaseController) }

  pending { should_not use_before_action(:authenticate).only(:create) }

  describe '#create.json' do
    context 'successful authorization' do
      before { expect(subject).to receive(:verify_authorized).and_return(true) }

      before { expect(subject).to receive(:build_resource) }

      before do
        expect(subject).to receive(:resource) do
          double.tap do |a|
            expect(a).to receive(:save!)
          end
        end
      end

      before { expect(subject).to receive(:skip_authorization) }

      before do
        post :create, params: { session: {
          email: 'me@example.com',
          password: 'password'
        }, format: :json }
      end

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    context 'failed authorization' do
      before do
        post :create, params: { session: {
          email: 'me@example.com',
          password: 'password'
        }, format: :json }
      end

      it { should render_template(:errors) }

      it { should respond_with(:unprocessable_entity) }
    end
  end

  describe '#destroy.json' do
    context 'authorized' do
      before { expect(subject).to receive(:verify_authorized).and_return(true) }

      let(:secure_token) { stub_model SecureToken }

      before { expect(subject).to receive(:secure_token).and_return(secure_token).twice }

      before { expect(subject).to receive(:authorize).with(secure_token) }

      before { expect(secure_token).to receive(:destroy!) }

      before { sign_in }

      before { delete :destroy, params: { id: '1234' }, format: :json }

      it { should respond_with(:ok) }
    end

    context 'not authorized' do
      before { delete :destroy, params: { id: '1234' }, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  # private methods

  describe '#build_resource' do
    let(:resource_params) { double }

    let(:session) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(Api::Session).to receive(:new).with(resource_params).and_return(session) }

    specify { expect { subject.send(:build_resource) }.not_to raise_error }

    specify { expect { subject.send(:build_resource) }.to change { subject.instance_variable_get(:@session) }.from(nil).to(session) }
  end

  describe '#resource' do
    let(:session) { double }

    before { subject.instance_variable_set(:@session, session) }

    specify { expect(subject.send(:resource)).to eq(session) }
  end

  describe '#resource_params' do
    before do
      #
      # subject.params.require(:session).permit(:email, :password, :name)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:require).with(:session) do
            double.tap do |b|
              expect(b).to receive(:permit).with(:email, :password, :name)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
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
        # subject.policy_scope(::Session)
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
