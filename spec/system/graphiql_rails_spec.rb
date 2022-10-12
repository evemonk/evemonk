# frozen_string_literal: true

require "rails_helper"

describe "GraphiQL" do
  it "should render page" do
    visit graphiql_rails_path
  end
end
