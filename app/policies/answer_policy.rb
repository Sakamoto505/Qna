# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    # user.admin? || user.id == record.author_id
    user.admin? || resource_owner?
  end
end
