class FlagsImporter
  attr_reader :flags

  def initialize(file)
    @flags = EveOnline::SDE::Flags.new(file)
  end

  def execute
    flags.flags.each do |flag|
      Eve::Flag.create!(flag.as_json)
    end
  end
end
