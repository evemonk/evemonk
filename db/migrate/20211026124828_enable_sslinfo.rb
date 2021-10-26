# frozen_string_literal: true

class EnableSslinfo < ActiveRecord::Migration[7.0]
  def change
    enable_extension "sslinfo"
  end
end
