# frozen_string_literal: true

require "rails_helper"

describe "Lookbook" do
  before { driven_by(:selenium_chrome_headless) }

  it "should render page" do
    visit lookbook_path
  end
end
