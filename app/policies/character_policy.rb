# frozen_string_literal: true

class CharacterPolicy < ApplicationPolicy
  attr_reader :user, :record

  # @param user [User]
  # @param record [Character]
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    scope.exists?(id: record.id)
  end

  def create?
    user.present?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      if user.present?
        user.characters.all
      else
        Character.none
      end
    end
  end
end
