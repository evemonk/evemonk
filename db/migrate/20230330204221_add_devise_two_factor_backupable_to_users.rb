# frozen_string_literal: true

class AddDeviseTwoFactorBackupableToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp_backup_codes, :string, array: true
  end
end
