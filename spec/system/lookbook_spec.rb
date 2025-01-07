# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Lookbook", type: :system do
  before { driven_by(:selenium_chrome_headless) }

  it "should render page" do
    visit lookbook_path
  end
end
