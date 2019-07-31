# frozen_string_literal: true

class AddEveCharCorpHistoryIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_character_corporation_histories, [:character_id, :corporation_id], name: "index_eve_char_corp_histories_on_char_id_and_corp_id"
    add_index :eve_character_corporation_histories, :corporation_id
  end
end
