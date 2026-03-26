# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Lookbook", type: :system do
  it "should render page" do
    visit lookbook_path
  end
end
