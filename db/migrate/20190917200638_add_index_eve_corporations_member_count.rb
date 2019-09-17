# frozen_string_literal: true

class AddIndexEveCorporationsMemberCount < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :eve_corporations, :member_count, algorithm: :concurrently
  end
end
