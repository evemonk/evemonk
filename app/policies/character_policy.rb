# frozen_string_literal: true

class CharacterPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.exists?(record.id)
  end

  def create?
    true
  end

  def update?
    scope.exists?(record.id)
  end

  def destroy?
    scope.exists?(record.id)
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user: user)
    end
  end
end
