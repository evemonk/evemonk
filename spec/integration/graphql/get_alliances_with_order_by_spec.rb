# frozen_string_literal: true

require "rails_helper"

describe "Get Alliances with orderBy" do
  let!(:eve_alliance_1) { create(:eve_alliance, id: 1) }

  let!(:eve_alliance_2) { create(:eve_alliance, id: 2) }

  let!(:eve_alliance_3) { create(:eve_alliance, id: 3) }

  let(:query) do
    %(
      query getAlliances {
        alliances(first: 3, orderBy: #{order_by}) {
          edges {
            node {
              id
              corporationsCount
              charactersCount
            }
          }
        }
      }
    )
  end


  context "when orderBy is CORPORATIONS_COUNT_DESC" do
    let(:order_by) { "CORPORATIONS_COUNT_DESC" }
  end

  context "when orderBy is CORPORATIONS_COUNT_ASC" do
    let(:order_by) { "CORPORATIONS_COUNT_ASC" }
  end

  context "when orderBy is CHARACTERS_COUNT_DESC" do
    let(:order_by) { "CHARACTERS_COUNT_DESC" }
  end

  context "when orderBy is CHARACTERS_COUNT_ASC" do
    let(:order_by) { "CHARACTERS_COUNT_ASC" }
  end

  context "when orderBy is NONE" do
    let(:order_by) { "NONE" }
  end
end
