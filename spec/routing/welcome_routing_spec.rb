# frozen_string_literal: true

require "rails_helper"

RSpec.describe WelcomeController do
  describe "routing" do
    it "should route / to welcome#index" do
      expect(get: "/").to route_to("welcome#index")
    end
  end
end
