# frozen_string_literal: true

class BaseEntity
  @attributes = []

  attr_reader :attributes

  def initialize(args = {})
    raise ArgumentError, "args should be a Hash" unless args.is_a?(Hash)

    puts args.inspect

    puts args.keys
    puts args.values
  end

  def readonly
    make_readonly

    self
  end

  private

  def make_readonly
    binding.pry

    attributes.each do |attribute|
      undef :"#{attribute}="
    end
  end

  class << self
    # attr_reader :attributes

    def attribute(name)
      raise ArgumentError, "name should be a Symbol" unless name.is_a?(Symbol)

      @attributes << name

      attr_reader(name)
      attr_writer(name)
    end

    def attributes(*names)
      names.each do |name|
        attribute(name)
      end
    end

    private

    def inherited(subclass)
      super

      subclass.instance_variable_set(:@attributes, @attributes.dup)
    end
  end
end
