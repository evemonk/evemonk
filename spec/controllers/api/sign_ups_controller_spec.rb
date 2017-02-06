require 'rails_helper'

describe Api::SignUpsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#create.json' do
    context 'user successfully created' do
      before do
        post :create, params: { email: 'me@example.com',
                                password: 'password',
                                password_confirmation: 'password',
                                format: :json }
      end

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    context 'unprocessable entity' do
      before do
        post :create, params: { email: 'me@example.com',
                                password: 'password',
                                password_confirmation: 'wrong confirmation',
                                format: :json }
      end

      it { should render_template(:errors) }

      it { should respond_with(:unprocessable_entity) }
    end
  end

  # private methods

  describe '#build_resource' do
    let(:resource_params) { double }

    let(:sign_up) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(Api::SignUp).to receive(:new).with(resource_params).and_return(sign_up) }

    specify { expect { subject.send(:build_resource) }.not_to raise_error }

    specify { expect { subject.send(:build_resource) }.to change { subject.instance_variable_get(:@sign_up) }.from(nil).to(sign_up) }
  end

  describe '#resource' do
    let(:sign_up) { double }

    before { subject.instance_variable_set(:@sign_up, sign_up) }

    specify { expect(subject.send(:resource)).to eq(sign_up) }
  end

  describe '#resource_params' do
    before do
      #
      # subject.params.permit(:email, :password, :password_confirmation)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:permit).with(:email, :password, :password_confirmation)
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
  end
end
