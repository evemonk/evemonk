class NamesImporter
  attr_reader :inv_names

  def initialize(file)
    @inv_names = EveOnline::SDE::InvNames.new(file)
  end

  def execute
    inv_names.inv_names.each do |inv_name|
      Eve::Name.create!(inv_name.as_json)
    end
  end
end
