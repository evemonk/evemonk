# frozen_string_literal: true

class RenameNpcCorporationDivision < ActiveRecord::Migration[7.0]
  def change
    rename_table :eve_npc_corporation_divisions, :eve_divisions
  end
end
