# frozen_string_literal: true

class SolidErrorFingerprintNonNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :solid_errors, :fingerprint, false
  end
end
