# frozen_string_literal: true

class EnablePgStatStatements < ActiveRecord::Migration[8.0]
  def change
    enable_extension :pg_stat_statements
  end
end
