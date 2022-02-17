# frozen_string_literal: true

class RemoveAttaches < ActiveRecord::Migration[7.0]
  def up
    ActiveStorage::Attachment.destroy_all
    ActiveStorage::Blob.destroy_all
  end
end
