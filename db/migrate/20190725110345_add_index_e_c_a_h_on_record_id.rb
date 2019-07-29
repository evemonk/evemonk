# frozen_string_literal: true

class AddIndexECAHOnRecordId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_corporation_alliance_histories, :record_id
  end
end
