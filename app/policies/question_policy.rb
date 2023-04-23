# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def index?
    true
  end

  def show?
    true
  end

  def destroy?
    user&.admin? || user&.id == record.author_id
  end

  def update?
    user&.admin? || user&.id == record.author_id
  end

  def comment?
    user.present?
  end

  def user?
    user.present?
  end
end
