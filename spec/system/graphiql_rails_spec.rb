# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphiQL", type: :system do
  before { driven_by(:selenium_chrome_headless) }

  it "should render page" do
    visit graphiql_rails_path
  end
end
