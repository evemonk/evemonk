# frozen_string_literal: true
class RenameSecureTokensToSessions < ActiveRecord::Migration[5.0]
  def change
    rename_table :secure_tokens, :sessions
  end
end
