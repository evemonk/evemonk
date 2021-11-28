# frozen_string_literal: true

class EnablePgBuffercache < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pg_buffercache"
  end
end
