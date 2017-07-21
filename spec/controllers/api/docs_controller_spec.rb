require 'rails_helper'

describe Api::DocsController do
  it { should be_a(ActionController::Base) }

  it { should be_a(Swagger::Blocks) }

  describe '#index.json' do
    before { get :index, params: { format: :json } }

    it { should respond_with(:ok) }
  end
end
