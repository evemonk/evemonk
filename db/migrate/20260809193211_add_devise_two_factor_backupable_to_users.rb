# frozen_string_literal: true

class AddDeviseTwoFactorBackupableToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :otp_backup_codes, :string, array: true
  end
end
