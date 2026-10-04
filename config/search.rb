# frozen_string_literal: true

# Define your search indexes here.
#
#   ActiveSearch.define_index(:articles) do
#     text :title
#     integer :account_id
#   end

ActiveSearch.define_index(:eve_alliances, source: "Eve::Alliance") do
  text :name
  text :ticket
end

ActiveSearch.define_index(:eve_corporations, source: "Eve::Corporation") do
  text :name
  text :ticker
end

ActiveSearch.define_index(:eve_characters, source: "Eve::Character") do
  text :name
end

ActiveSearch.define_index(:eve_types, source: "Eve::Type") do
  text :name_en
end
