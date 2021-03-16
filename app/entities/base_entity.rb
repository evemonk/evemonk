# frozen_string_literal: true

class BaseEntity
  @attributes = []

  class << self
    def attribute(name)
      @attributes << name

      attr_reader(name)
    end

    def attributes(*names)
      names.each do |name|
        @attributes << name

        attr_reader(name)
      end
    end
  end
end
