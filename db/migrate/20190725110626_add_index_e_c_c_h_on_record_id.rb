# frozen_string_literal: true

class AddIndexECCHOnRecordId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_character_corporation_histories, :record_id
  end
end
