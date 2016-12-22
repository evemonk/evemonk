class ItemsImporter
  attr_reader :items

  def initialize(file)
    @items = EveOnline::SDE::Items.new(file)
  end

  def execute
    items.items.each do |item|
      Eve::Item.create!(item.as_json)
    end
  end
end
