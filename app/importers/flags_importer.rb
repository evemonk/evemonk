# frozen_string_literal: true
class FlagsImporter
  attr_reader :inv_flags

  def initialize(file)
    @inv_flags = EveOnline::SDE::InvFlags.new(file)
  end

  def execute
    inv_flags.inv_flags.each do |inv_flag|
      Eve::Flag.create!(inv_flag.as_json)
    end
  end
end
