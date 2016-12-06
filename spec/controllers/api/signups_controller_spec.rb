require 'rails_helper'

describe Api::SignupsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe '#create.json' do
    before do
      post :create, params: { user: {
        email: 'me@example.com',
        password: 'password',
        password_confirmation: 'password'
      }, format: :json }
    end

    it { should render_template(:create) }

    it { should respond_with(:ok) }
  end

  # private methods

  describe '#build_resource' do
    let(:resource_params) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(Api::Signup).to receive(:new).with(resource_params) }

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
      # subject.params.require(:user).permit(:email, :password, :password_confirmation)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:require).with(:user) do
            double.tap do |b|
              expect(b).to receive(:permit).with(:email, :password, :password_confirmation)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
  end
end
