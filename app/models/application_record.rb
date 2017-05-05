class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def decorate
    ActiveDecorator::Decorator.instance.decorate(self)
  end
end
