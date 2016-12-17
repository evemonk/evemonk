class FlagsImporter
  attr_reader :flags

  def initialize(file)
    @flags = EveOnline::SDE::Base.new(file)
  end

  def execute
    flags.data.each do |flag|
      Eve::Flag.create!(flag)
    end
  end
end
