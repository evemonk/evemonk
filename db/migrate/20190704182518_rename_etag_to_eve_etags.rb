# frozen_string_literal: true

class RenameEtagToEveEtags < ActiveRecord::Migration[6.0]
  def change
    rename_table :etags, :eve_etags
  end
end
