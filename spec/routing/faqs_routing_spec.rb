# frozen_string_literal: true

require "rails_helper"

RSpec.describe FaqsController do
  describe "routing" do
    it "should route GET /faq to faqs#show" do
      expect(get: "/faq").to route_to(
        controller: "faqs",
        action: "show"
      )
    end
  end
end
