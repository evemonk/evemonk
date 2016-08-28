require 'rails_helper'

describe Api::SessionsController do
  it { should be_a Api::BaseController }

  it { should_not use_before_action(:authenticate) }

  describe '#create.json' do
    context 'successful authorization' do
      before { expect(subject).to receive(:build_resource) }

      before do
        expect(subject).to receive(:resource) do
          double.tap do |a|
            expect(a).to receive(:save!)
          end
        end
      end

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

  # private methods

  describe '#build_resource' do
    let(:resource_params) { double }

    before do
      expect(subject).to receive(:resource_params).and_return(resource_params)
    end

    before { expect(Api::Session).to receive(:new).with(resource_params) }

    specify { expect { subject.send(:build_resource) }.not_to raise_error }
  end

  describe '#resource' do
    let(:resource) { double }

    before { subject.instance_variable_set(:@resource, resource) }

    specify { expect(subject.send(:resource)).to eq(resource) }
  end

  describe '#resource_params' do
    before do
      #
      # subject.params.require(:session).permit(:email, :password, :password_confirmation)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:require).with(:session) do
            double.tap do |b|
              expect(b).to receive(:permit).with(:email, :password)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
  end
end
