# frozen_string_literal: true

class BaseEntity
  @attributes = []

  class << self
    # attr_reader :attributes

    def attribute(name)
      raise ArgumentError, "name should be a Symbol" unless name.is_a?(Symbol)

      @attributes << name

      attr_reader(name)
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
