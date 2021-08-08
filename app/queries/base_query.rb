# frozen_string_literal: true

class BaseQuery
  def scope
    raise NotImplementedError
  end

  def query
    raise NotImplementedError
  end
end
