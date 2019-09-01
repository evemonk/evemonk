# frozen_string_literal: true

class CreateEveTypeDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_types, :description, :description_en
    add_column :eve_types, :description_de, :text
    add_column :eve_types, :description_fr, :text
    add_column :eve_types, :description_ja, :text
    add_column :eve_types, :description_ru, :text
    add_column :eve_types, :description_zh, :text
  end
end
