# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user&.admin? || user&.is_owner?(record)
  end

  def destroy?
    user&.admin? || user&.is_owner?(record)
  end

  def comment?
    user.present?
  end

  def set_best?
    user&.is_owner?(record.question)
  end

  def user?
    user.present?
  end
end
