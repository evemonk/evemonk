# frozen_string_literal: true

class RemoveAuthy < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.remove :authy_id, type: :string
      t.remove :last_sign_in_with_authy, type: :datetime, precision: nil
      t.remove :authy_enabled, type: :boolean, default: false
    end
  end
end
