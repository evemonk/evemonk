# frozen_string_literal: true

class ItemsImporter
  attr_reader :inv_items

  def initialize(file)
    @inv_items = EveOnline::SDE::InvItems.new(file)
  end

  def execute
    inv_items.inv_items.each do |inv_item|
      Eve::Item.create!(inv_item.as_json)
    end
  end
end
