class ItemsImporter
  attr_reader :items

  def initialize(file)
    @items = EveOnline::SDE::Base.new(file)
  end

  def execute
    items.data.each do |item|
      Eve::Item.create!(item)
    end
  end
end
