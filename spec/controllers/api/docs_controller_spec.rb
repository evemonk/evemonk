# frozen_string_literal: true

require "rails_helper"

module Api
  describe DocsController do
    it { should be_a(ActionController::Base) }

    it { should be_a(Swagger::Blocks) }

    # protect_from_forgery with: :exception

    describe "#index" do
      before { get :index, params: {format: :json} }

      it { should respond_with(:ok) }
    end
  end
end
