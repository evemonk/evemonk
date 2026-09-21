# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PgHero", type: :system do
  it "should render page" do
    visit pg_hero_path
  end
end
