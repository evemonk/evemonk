require 'rails_helper'

describe Api::SignInsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#create.json' do
    context 'successful authorization' do
      let!(:user) { create(:user, password: 'password') }

      before do
        post :create, params: { sign_ins: {
            email: user.email,
            password: 'password'
        }, format: :json }
      end

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    context 'failed authorization' do
      before do
        post :create, params: { sign_ins: {
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

    let(:sign_in) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(Api::SignIn).to receive(:new).with(resource_params).and_return(sign_in) }

    specify { expect { subject.send(:build_resource) }.not_to raise_error }

    specify { expect { subject.send(:build_resource) }.to change { subject.instance_variable_get(:@sign_in) }.from(nil).to(sign_in) }
  end

  describe '#resource' do
    let(:sign_in) { double }

    before { subject.instance_variable_set(:@sign_in, sign_in) }

    specify { expect(subject.send(:resource)).to eq(sign_in) }
  end

  describe '#resource_params' do
    before do
      #
      # subject.params.require(:sign_ins)
      #               .permit(:email, :password, :name, :device,
      #                       :device_token)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:require).with(:sign_ins) do
            double.tap do |b|
              expect(b).to receive(:permit).with(:email, :password, :name, :device, :device_token)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
  end
end
