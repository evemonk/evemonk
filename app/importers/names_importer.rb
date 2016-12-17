class NamesImporter
  attr_reader :names

  def initialize(file)
    @names = EveOnline::SDE::Base.new(file)
  end

  def execute
    names.data.each do |name|
      Eve::Name.create!(name)
    end
  end
end
