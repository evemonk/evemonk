class NamesImporter
  attr_reader :names

  def initialize(file)
    @names = EveOnline::SDE::Names.new(file)
  end

  def execute
    names.names.each do |name|
      Eve::Name.create!(name.as_json)
    end
  end
end
