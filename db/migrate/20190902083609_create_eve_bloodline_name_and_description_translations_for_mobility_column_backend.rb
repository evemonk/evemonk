# frozen_string_literal: true

class CreateEveBloodlineNameAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[6.0]
  def change
    rename_column :eve_bloodlines, :name, :name_en
    add_column :eve_bloodlines, :name_de, :string
    add_column :eve_bloodlines, :name_fr, :string
    add_column :eve_bloodlines, :name_ja, :string
    add_column :eve_bloodlines, :name_ru, :string
    add_column :eve_bloodlines, :name_zh, :string
    rename_column :eve_bloodlines, :description, :description_en
    add_column :eve_bloodlines, :description_de, :text
    add_column :eve_bloodlines, :description_fr, :text
    add_column :eve_bloodlines, :description_ja, :text
    add_column :eve_bloodlines, :description_ru, :text
    add_column :eve_bloodlines, :description_zh, :text
  end
end
